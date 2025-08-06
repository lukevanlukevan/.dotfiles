import argparse
import requests
import sys


def add_torrent(magnet_link, category):
    """Add a torrent to qBittorrent using the provided magnet link and tag."""
    url = "http://pop-os:9090/api/v2/torrents/add"
    data = {"urls": magnet_link, "category": category}

    try:
        response = requests.post(url, data=data)
        if response.text == "Ok.":
            print(f"Successfully added torrent with category '{category}'")
        else:
            print(f"Error adding torrent: {response.text}")
            sys.exit(1)
    except requests.RequestException as e:
        print(f"Error sending request to qBittorrent: {e}")
        sys.exit(1)


def main():
    parser = argparse.ArgumentParser(
        description="Add a torrent to qBittorrent via Web API"
    )
    parser.add_argument("magnet_link", help="Magnet link of the torrent")
    parser.add_argument("category", help="category to assign to the torrent")

    args = parser.parse_args()

    add_torrent(args.magnet_link, args.category)


if __name__ == "__main__":
    main()

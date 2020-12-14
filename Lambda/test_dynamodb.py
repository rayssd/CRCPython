import dynamodb
import boto3


def test_updateDDBItem():
    ddb = boto3.resource('dynamodb')
    MyTable = ddb.Table('MyTable')
    original = dynamodb.readDDBItem(MyTable)
    target = original + 1
    assert dynamodb.updateDDBItem(MyTable) == target, f"Should be {original}!"


if __name__ == "__main__":
    test_updateDDBItem()
    # print("Everything passed")

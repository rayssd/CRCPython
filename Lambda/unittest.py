import dynamodb
import boto3


ddb = boto3.resource('dynamodb')
MyTable = ddb.Table('MyTable')


def test_updateDDBItem(MyTable):
    original = dynamodb.readDDBItem(MyTable)
    target = original + 1
    assert dynamodb.updateDDBItem(MyTable) == target, f"Should be {original}!"


if __name__ == "__main__":
    test_updateDDBItem(MyTable)
    print("Everything passed")

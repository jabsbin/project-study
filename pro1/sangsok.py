class ElecProduct:
    volume = 0

    def volumeControl(self, Volume):
        print(f"{Volume} 출력")

class ElecTv(ElecProduct):

    def volumeControl(self, Volume):
        print("tv 음향 조절")
        print(f"{Volume} 출력")

class ElecRadio(ElecProduct):

    def volumeControl(self, Volume):
        print("Radio 음향 조절")
        print(f"{Volume} 출력")

c1 = ElecTv()
c1.volumeControl
print()
c2 = ElecRadio()
c2.volumeControl
print()

c = ElecProduct()
c = c1
c.volumeControl(2)
print()
c = c2
c.volumeControl(2)
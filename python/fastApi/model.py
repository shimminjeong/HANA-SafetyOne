
from pydantic import BaseModel
from datetime import date

class categoryEmbedding(BaseModel):
    categoryCode: str
    categorySmall: str
    barToEmbedding: float
    diamondToEmbedding: float


class regionEmbedding(BaseModel):
    regionCode: str
    regionName: str
    seoultToRegionTime: int
    seoultToRegionDistance: int


class fes(BaseModel):
    CARDID: str
    SERREGDATE: date
    LEARNINGDATE: date
    SERVICESTATUS: str
    WEIGHTSAVEPATH: str
    CATEGORYSMALLSTATS: str
    REGIONSTATS: str
    TIMESTATS: str
    AMOUNTSTATS: str



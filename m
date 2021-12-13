Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA44C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 20:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhLMUx7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 15:53:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8524 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236136AbhLMUx7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 15:53:59 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDIj3cA022068;
        Mon, 13 Dec 2021 20:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S2cuEGMH9XpbXDHZCCNTUtVeX1hFcdmZeTy16k5PkvY=;
 b=ber6VrGtndnPr7hbenTimbXrvxvuAvkjfpVSovLMzv+jmdMTDDBMD3IMidtfP3x9FTPu
 346TWfw9tPgML1c8976f+OjqiE6B/gsCDJfN1KBc8flEAsYkQh9zbDGvlPWnY9JlPaYq
 xb74+mM68/COsaeFmZ4mXxjv5xkyaQ6+NvOJyc5mpigWee5q4scoH8BLbfY0H9Gis9PW
 5UNwBxehQuX1X20QKEJuqvgDKJ2Eju2aGo4MsdWzTsiegPaVNoxqR+GBraE4hePgpZL3
 XHN2lXHLB2fFOtfjN+bCnUSbdP7kcBh49ITEa6yhyWKSp/5wfVLGJrs1SgukTpLsbdPj vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfa0tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 20:53:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDKpZks015480;
        Mon, 13 Dec 2021 20:53:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3cvh3w45vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 20:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxDr8qEJ9FesGU7dPb/Yat9q0XGG9rPiOfA4FKvt2OWZ2CcL+SINdjVucg7xmr2WKIszGxhc27VPyOP+LgIpkBJGpJDwG2YiRd7KwgW58uZthya9Pw9/D6h8v7FX7HbBVIBazovIZdIg9H9iVLjT04UNyig/BEBCHnPRGVfR5ONJ7UK3tPELIHfECDOCl2JZHENypYk1JL6hanZlCo4H6M4/LlQ1tVjTECe4IcoitpJIHCOGiXYULBd9pzY9SRI1t1f3lzP4lc8136CvBNhTtPIGew8XzQva/a+Q+LNFxfo8HH3u0SstGbLW4AAJEK4wz9ghIGOfZhW1nFr3Si+vXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2cuEGMH9XpbXDHZCCNTUtVeX1hFcdmZeTy16k5PkvY=;
 b=bb2DGUQlko73fx1q3gTHGoacbvpkkRUc9AlyPmagepTyf5tBsljs4EsXM0PCdxzl1GadfztRnXoH0tjJc/2sYOX5/aP+GQ/UHcp2KhCW4L8uS7HhWQG7KUqOtdxrN0nXBihXJCRs+/Zu3tZqQaadiNdMg8jMfQ27QngrI0vV+VuXhkYnEpACqBMyvrDb2b8XfhyA4pLaeth21hf7SloyEgqjIfcsvjmSPse8EXNhVOODwpErl1nPsVQcCMKAeoSzyXq4CLLqQ8WWVjk/NqTpP/oM5Opfnyu3vw3aY1mRxZU1Fo23kSy4q5koM/LIum9xh9rbQfdPaqnbo4RevKXJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2cuEGMH9XpbXDHZCCNTUtVeX1hFcdmZeTy16k5PkvY=;
 b=TjeKl5h5Czm9I0HPmeIbn8zr/D4SKgRBHbZl4UCeLpHP8RQD8ySIaSE2rZjesRCmoiTz1vo+UheqYTBbKePakNrxzY68PzSG1Os/p6G2RTBqJDFzxYtNU5HadOhP0xoZSHX6mLgqZCjB9UNs5QUTZKiS+3hZ0aI08GK7xA/GSMQ=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2607.namprd10.prod.outlook.com (2603:10b6:805:4e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Mon, 13 Dec
 2021 20:53:42 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 20:53:42 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Assorted improvements to usercopy
Thread-Topic: [PATCH v3 0/3] Assorted improvements to usercopy
Thread-Index: AQHX8C3j0tPdDVNl7EG/pV1VSpDyWKwwzC8AgAATNwCAAAWqAIAAAZoA
Date:   Mon, 13 Dec 2021 20:53:42 +0000
Message-ID: <E8BDFBD1-5A72-4C90-9B02-29798F121B13@oracle.com>
References: <20211213142703.3066590-1-willy@infradead.org>
 <196BFB9E-9A72-48B1-863E-021DE0B162A7@oracle.com>
 <YbesvmxAI3P5UFnv@casper.infradead.org> <202112131246.4BBFBA69A@keescook>
In-Reply-To: <202112131246.4BBFBA69A@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5a8a7fe-d19a-4ddc-784f-08d9be7aa5d9
x-ms-traffictypediagnostic: SN6PR10MB2607:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2607F257286679DD800701D781749@SN6PR10MB2607.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +HOh4NgTEpgw5n0EQkrOO40gjJMfPnCU+c9bW9VnADAQ9eOodf7zGb38xkSeckdJHlDq5migiLMzYwu/OzAisMFpp0cqhCIeJX/8QI8RndkSVQSxoCFjEgR0SQ6qRay/xFUjnbqS2SeLCwzlfTLirFx/54uyzv/MGK3hFfdswLp4KTIOHykbrbw5ChgiBlcFR/8N8cLe7XBKin0tzm18EUl1mUHFY4AZzZH1nlWmhphpG51D3Axb6zlNBFCLv/jz8g6wGBzzGzBgAmS1hRaHahkkGE/i2wlW3wBp81BWdiK8wYC5oN2a2V20nPU1aYZ4FJo1dbypRPZcrGPQHaoH7V5jSBcoxRgqo8B8RD+7N0fymfY0FPOc8IX9N6enAIdpI7IZigKNsqFGjO2SXY5nHNfNQGG1UbAAeuqfATcB9g5JK6gjXPPDheiRoa95IVg9clJJchP4RtqYwNvpdRYgV0xj6q0NEFdKwLS5nB8XTTNoqnqzpiB7EjKjsUKfQPdDSsNZBc/1gaoFZMfdBPpmZxShNnNyHDQf1kjdBV2jMNtXnEKswVvpv6uibZPiNL8HpSbuGAI85FUVts1LFvlF0KZPNW6P73hGcxKkbaDxD08WtUT9cWrv6Q5C46PLs0oOXIqVbCONFTTLQ7gpkoqxptU2JFjP2IbrPnnyCZaWaRQ23TKJ7Ee7y4n8BNx+SBurxDLvCBsdIUeWBQihUHLKHfs4unWemSB6BzQnVEoOTpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(86362001)(2906002)(71200400001)(38070700005)(186003)(38100700002)(66476007)(76116006)(122000001)(6512007)(316002)(33656002)(44832011)(2616005)(66556008)(6916009)(508600001)(66946007)(8936002)(83380400001)(6506007)(91956017)(4326008)(8676002)(64756008)(5660300002)(6486002)(53546011)(66446008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W5G3Q0r6Rmbgk0Rkop8YiX4mbMKMmQfu5fxrT0vUe1f5AwsUIXGNu3RvAw1C?=
 =?us-ascii?Q?HYRsSTFqPz6m4ZN4v0FMo3TiJLMagezjkJNnY9NuYNxVCrVi+CK71tjeQkk/?=
 =?us-ascii?Q?rVYbHjWwjTuv9o2FDNKRyQBVTNBS0gErDLfrsy1XNaFscUR5FcWz21j2kZ9H?=
 =?us-ascii?Q?O46nFrsLocrfAB18zCSyLpSBOQqWbrI+G/3OMRHn++cJupPtRxlLIecWS3LT?=
 =?us-ascii?Q?WSJs/nvTsf+OX0yvTuH5J58ZvO3mT4I4VxyL0d6QP3VaZs+1eoaWXcZ70+Yd?=
 =?us-ascii?Q?sjN3LJwYV0ZHTRtLnuoBJ1p62BJQmckI68q25GTZFmvVqL8FRaAubQokrKW1?=
 =?us-ascii?Q?zwchDvzjio/k4lXhR6LM5IfWtsh09NUzO+b0OK31nrXzYKuFRa47lCVzgh8/?=
 =?us-ascii?Q?BfoLZPHnSQwH3NEifgub91NBbTBinLrKA+O5NLy07l4VNzknZk2Oux5sR7C6?=
 =?us-ascii?Q?wkjhWUvPYyFQ8adHIpvaguRI8D+61QJMgB/7c7gMvI1oFhBnb0O3dU6vEz9a?=
 =?us-ascii?Q?nQd0n7SYqi4pQl4mgJR6ObuPrnEvBCUtQBZKMqP6Qzd7eVuAMvHE+0N2bC6l?=
 =?us-ascii?Q?O0kTCSnjZDWqIjqnilMC0dnYoHAVH3TRVcG4atsuwyt9KZ6TcvtDjKJ9MTR/?=
 =?us-ascii?Q?m8tXVnoUac8j6g5kSFAVUmuwElM/8x6CTSReKKagWhdNusUI6lxNI8GMoPML?=
 =?us-ascii?Q?cGSu68TiYzcfI8h9B8TE6c62sl9x3hd6vOSjsIMva5RdWM48nsx6Pb1WralF?=
 =?us-ascii?Q?WjkqnxKSipIPq2Yj6ivbhgjn7x7KmxNwe1DlLJ34ua6BqLOIwhjnJoxIbVMy?=
 =?us-ascii?Q?H+Fa9+isIa1RcF9rVpB3guny+HUwC/5druWoEYhw4sMd/TkkKEdz8dOpzdB2?=
 =?us-ascii?Q?2C/US1FqN8CDBfjo5JtACGVjaLez8rTAo4sdqVuh0tpUjCK1vNkT6UCwhw3m?=
 =?us-ascii?Q?6DRSxDCJm6Z5N4NumYGjgeYHHOnWu5Zlbxufg6FGBRhpVN8PQ1uM6AvtJ4gY?=
 =?us-ascii?Q?cnxN9xK97JjEPZfT0wB17umEr6m3JbCBDCbbOcUfmC16jmNM3wfd1ViS008Y?=
 =?us-ascii?Q?MgMFXlVm+iBBiYVCGp589ub2cpGjopHUvvTFAj9z7U12kQYTzss4vXf/v7Y2?=
 =?us-ascii?Q?CytTrP1yjbv305UMGXHkW0stlAqGPr2Q1gmoTGOp0NLQK5KSagzCRoArGw0U?=
 =?us-ascii?Q?YBRB4pfa9X/rIbdbKs+RkfJZ0e+mntsr58+aWSrhtc1o6RmCjL8Q93KDccki?=
 =?us-ascii?Q?TTfuIkrR+1kOChkNCB8ZF9db9LySmf/T21LLUBDN9R1z8F9FmHYWO9eIGt8l?=
 =?us-ascii?Q?aEztu8P1oIyw9BtA1kPB/hs7lFUEg9TmApeaQ319P7Nj5t2YumaPmbCktcTH?=
 =?us-ascii?Q?IiwcH4ewWQbDyKLzmMJdQHKVQSCloOd3CuxWGERti3NeHD46MKrseYD+lSY7?=
 =?us-ascii?Q?8CJulDQ9btWxhWP7iV/W7ew8a72FJig5RoD5McCLqXcbQF+wzDNJ6X1U2Z+n?=
 =?us-ascii?Q?kCHQZx9g0mvZ+NVljrYMNVFh3Ayms6GwoPxsZFzHp4pjsRlf3pa3virclQVO?=
 =?us-ascii?Q?WNt2Vp52DvIPiwT9ljjKuDKbikprreFk5Mj1vK9ZwLnCGG8ffpvOVaP8T56X?=
 =?us-ascii?Q?hfofw5DfyimzBZfmWsOgse3sErkVYB/TNLSWJqIEnfe7su4qXsIN+v37bOlb?=
 =?us-ascii?Q?xCcWo7b1NRf4YFpD46msqxh6NG5iZREfdhYZhIvV6BeCv6VZbWqOL8ADp1SY?=
 =?us-ascii?Q?GbFS5158sDOsPp7s4BN5GOs/DiPvTJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E33CBA9864AF3E47A2DE7CC40BD9CBA4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a8a7fe-d19a-4ddc-784f-08d9be7aa5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 20:53:42.5783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9Pu0Yfq2896jtZ868rLplg3Yl4VWYdZYYPHj+XzzsPFDvafFTFfznIAnIlRf6/8qZusrViAMwtguJV6XvRZYPTPcKwnur9Hc2EuFcYPMXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2607
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=909 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130123
X-Proofpoint-ORIG-GUID: FGVzphtNQIV4t-sqiwnn3pH4c69B0gne
X-Proofpoint-GUID: FGVzphtNQIV4t-sqiwnn3pH4c69B0gne
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks, good explanation.

> On Dec 13, 2021, at 1:47 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> On Mon, Dec 13, 2021 at 08:27:42PM +0000, Matthew Wilcox wrote:
>> On Mon, Dec 13, 2021 at 07:18:57PM +0000, William Kucharski wrote:
>>> I like these, but a quick question:
>>>=20
>>> Since the usercopy_abort() calls are all because the offset exceeds the=
 page
>>> size, is there a reason why you don't specifically state that via the d=
etail
>>> parameter rather than just supply a NULL pointer?
>>=20
>> Hmm ... I'd defer to Kees on this, because I'm not familiar with
>> usercopy_abort() usage, but the only places which use the detail
>> parameter today are slab/slub, which use it to pass the name of
>> the slab.  I think the user is supposed to infer that we overran the
>> end of the page based on the offset & length values.
>=20
> I agree that leaving it NULL is best here. The "detail" is really about
> adding more information about which thing it was, which for slab makes
> sense, but most other stuff there isn't really anything to quickly
> distinguish one from another (i.e. vmap is all vmap).
>=20
> --=20
> Kees Cook


Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC67AC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 19:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhLMTTR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:19:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55508 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235389AbhLMTTR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 14:19:17 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDIitIU004121;
        Mon, 13 Dec 2021 19:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yhEDe23ZYibONsqkphlEr7PszSx6QJdxJ1hp+KcaJ3I=;
 b=RTiG9GZXQCEX8pfamOMhuTDwFgn13snW28IuJkSMZuHj9oxS7awz4MKYhUt14iNzcVQS
 F3uuYjbuMYAYVdJa2lOwc/izgM7MoDlAZB5FiUX3kYPNs+4+WSkPAlp7FHhr8gY9Px7v
 xv6YAPA7X9gmCybWwEGvG3BJOOZJLYDFF47fazXdcXrFf3QQ300M6AoDbH30nu7/99cY
 erNTVlfwquwWg7Kw+Sl+u17GMQjh+7v3DMRU7+7X4a152UB25sjgieiV/RADTjk7R5g+
 aTWUW0iklS6fcm51Kfts8M0nUPcR+rYJsWvHX1Dylx0SSz9Utolw+o2VpW2iBRTmK5ET Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py1jj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 19:19:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDJBVYO047754;
        Mon, 13 Dec 2021 19:18:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 3cvh3w0k3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 19:18:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0YuYImotglFT6vdeJ8a3voijQDcMgBDT6fKVO+Tn8ZLBypRHfmcSqZJrEzzBsFEoS6zWEM9FryMyOgW3qWRykR8uhO6IrOc5Eib40OBSGg9hMXdVsTfRs5iogcZS5mCCRtJ1JZXZo+LRhbHN4bmUYZP7EHHkGfCPQZ4rxrzmxKNYgooDxW68C+cYZ4LhE712/Ou7lvIWJagIejP+ouyrM4F+f4xE86VY0cTn57XhCooJtMs+AlMYuGInUTc1OXceM7Yn42/9qSqcVS7dBYX6hFtn85nvg4vxj54MEqY0oJtUOt28iTfi6q4t90MSjPu6p0P4BEUVhAI20mlAuP/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhEDe23ZYibONsqkphlEr7PszSx6QJdxJ1hp+KcaJ3I=;
 b=YHCS1+EzZncRcH9Lko4Y3dUd3V1uBSZGRlM16H9M176GgSY2bUWdKATlLmUC1HLrwyR+syd88KypL4RDeLzauedttR09zeHQO1apAJPJBI5f+F6GsLMm7RLkiqHuBDYgjWbBPfgnQh+N37tFbyYZsfgDgQBf/c4Pu3zAim1AakvENYmbwu3GGIYB4J7/tjSkSxaQW69/z27eAMcxRm87yuU+ZCwlKzeeaZgQmqSo+twnDI02ghEloSjrRjbLhTDHRpNWTluqxWtvhwoNqQKkqpb5szFeOdHjlaz3zv1pYQ+aNXF4CKBAqtATLF7KdPZ5jR52PorToPbu2dbKiPbSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhEDe23ZYibONsqkphlEr7PszSx6QJdxJ1hp+KcaJ3I=;
 b=QCrUZdLa8b+LciZtRuvrDp8Ms6Jze5z5QHcn395vuM9M4asNiXQsKDloPf6qHuBk1yJAAs2jJsko+Fo1Iw219QCB1rKVRipjB/Z/MgVvY0XhAjo1aduN3gVPqS5a54rkIjhSViw/LnBDuz6UBr0zxWcZCBjVlm9mRhEScpWwlik=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2749.namprd10.prod.outlook.com (2603:10b6:805:4b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 19:18:57 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 19:18:57 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Assorted improvements to usercopy
Thread-Topic: [PATCH v3 0/3] Assorted improvements to usercopy
Thread-Index: AQHX8C3j0tPdDVNl7EG/pV1VSpDyWKwwzC8A
Date:   Mon, 13 Dec 2021 19:18:57 +0000
Message-ID: <196BFB9E-9A72-48B1-863E-021DE0B162A7@oracle.com>
References: <20211213142703.3066590-1-willy@infradead.org>
In-Reply-To: <20211213142703.3066590-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d20ed827-8190-4001-0ef7-08d9be6d68fe
x-ms-traffictypediagnostic: SN6PR10MB2749:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2749994FC2F3016B717E9DC981749@SN6PR10MB2749.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3V+hCPJ5qHoggr2aV19KzJPOGaiIGVW+09wvn+8LHu/CtppetCxEvTT9WGvZdTs/AHM+jU4dGLnp1nLKk0JduEOxh2QEUlXfhbhW78fWx7qND6WNt038X6aAz5xVxPa13oumpnK1tvvQc9H3XEnPOxzjpJwIN8aCYON0MJrYfwj0pyyZVnSrjM/gxV6zpihKWcbWqjFTk1nvfP/YNUbaflEOjHf9RKkzNAfwZpoIkSgatRY5zl4RLCFQxgDXBw175lZdsxNb+ZdafnwpscKimSyQdPGTw6ssXvDJnnyGD4g05cfqrcS70UwLK049iKT7LMDIZ/AFi+UatooX/JeNv4oa9EPrJT4201uTptBNHbQIPtYBtxsKDzP5Mgt49uWB9GoAYo/PLXDMKWoqC2HbwdkbB/TL/buh/ZkyVVlyZQUR2LrmoTvaj3L4wzZZ4+i/EP1Oa3oKuozCFKSm9LqRkogy24NfQ0vnukGx3ZNRlomX8KwmAQynl+E2ouNwY5RZ3bGnje6m1mGs0PWCUPYJl6O2r/gb7gpZaoobD1aC/5cTAo9oqTYnJQ9VqHOpzde86iW8CgVEmVONYPclrVcIHqh5OgzaRpCAgXMEDXAfG42+gr5cX0GqasDwNSrV8X7HOgX9DaC99Bp93se53UhNKcIhoBm1O17hneZkG4JjmWIDgFao0rgeRelDssXYC3CuCdcZlJHthwWJtXNKRLelRWybJb9xBAqfSkP89oLco4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(38100700002)(33656002)(83380400001)(6512007)(54906003)(316002)(508600001)(36756003)(2616005)(186003)(8676002)(53546011)(91956017)(64756008)(2906002)(71200400001)(66446008)(6506007)(66946007)(66476007)(8936002)(86362001)(6486002)(76116006)(4326008)(5660300002)(38070700005)(44832011)(6916009)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yi48aEMxAW9HqGUtzT7RKJWbQmi1FULiIczQLO1sMJivvRkECP+daZWFIhEc?=
 =?us-ascii?Q?qs6T1xP8ZIJ3x7ybj58LAwOk+LRAQVDcUmmFxOaHKqnCC6sMLcfhWypw7UjD?=
 =?us-ascii?Q?WiIWnBHEXWq0PR3MRvhvECbO0y+D2c5ScEeN0crf3jsTAB+JpD9ajcro6LKc?=
 =?us-ascii?Q?JHrCBbhLhq0Ix8F0aqGRZYngGE5UrhBHfzOEHYrSmDZoBCU9RVqLOF/7YvUa?=
 =?us-ascii?Q?bIG/xaju6fuEatKCVF5YO+KoUPy1bLpYxC3KYs5NaUeSpoL4cpBHYTC153i8?=
 =?us-ascii?Q?j2nUdRjfJdhzmZxpu7hfiNmARSQMJb1yodYc3Cmax3de7OaXiOIoWRDhsIlt?=
 =?us-ascii?Q?WPQ8eI34aXEwTFsTC7WFPpd394R5z8VdRVU2ciauHcLVbW1jb5Z/SNe2HN3J?=
 =?us-ascii?Q?oE5/tUph1tS4viaUVIohxzPnQSgIryWyeFWfpWo5tRQHUOXeIWxc9IHpWCDG?=
 =?us-ascii?Q?FcEir5GCWZyDPhNfS4iyiSSG43hCVwt4uFg9E0/nZQnWEPN9bUxWtuH9P4La?=
 =?us-ascii?Q?+KQKcpiLiEloeaqnfeBkrag7nZon4prJ10+ANJfDxN4gTl4lKDlfA6fGrq5J?=
 =?us-ascii?Q?mDPs3Xtr81V6xB87+JScm+QSWx0K3SQny1OroS/JG1j8ETQjC+vrMnCyiZf9?=
 =?us-ascii?Q?wGM6gFAwxV2WsRNGIgWqZDXEOdMfcM+9lW4WIbLb89aNZ9ZC/q31Ac0owFZg?=
 =?us-ascii?Q?lrnkZCPlxivzN6IqDCpExY9B/NBhJcZFoo34tHHLUgXbNiBVVw8X83+23LBZ?=
 =?us-ascii?Q?pf5j6GldIuN+ycL3mOK8WSm2TbOXxEWt7IpqKNiYn8h5n0MzkP7uZUws3qed?=
 =?us-ascii?Q?11ugLnXyYA4OZc/QxQxYc3qv42iEIzRg+//JkrLAYDnDyEJQThDQaSZunvln?=
 =?us-ascii?Q?kEZdor9o23TAanHr8P9tApCNoJ6Hzs7zMHDQnNRq3l/z0q/iew8sJ9poWRk2?=
 =?us-ascii?Q?gDCFfVoOqlwLXIkeET5xQoSK29qsUFJGd0vdeXEHEKU90LQk7XNY6lREoZAB?=
 =?us-ascii?Q?b3Uk3Yw4pEUyqNnjIcdax6FlQbFgvjzKQuvuxG5PONo5f1QNpM9a3HHhPvO+?=
 =?us-ascii?Q?W5vYXHbqZh3Ug9viibxs7ere99NFTpLsr/HMd4HuFVZUn4nemKSmBEJKXdc7?=
 =?us-ascii?Q?tk+eLZtNsuofrnFHBN3ZWOEWd8gi3pmi9m6Uz/qnBNhGEURTdmP2VFIyIrCn?=
 =?us-ascii?Q?f29/RWzI4MRaxNAevjy3e2bwDow3YbF53JR8s1vR2aYRQO+yupTKFZ6a5Ncf?=
 =?us-ascii?Q?VaI5Dmyoe6H6eU41nD7lP0s1jGSGTGfnQCE8WHUETKxEUEyw3O8g5xgDzHH4?=
 =?us-ascii?Q?UgotM/4EgzTIDYL3FfLalLEVvzyr73Fs68h71tyQLVZFc9beiKClJPUyH0cA?=
 =?us-ascii?Q?hpreG5oDIs9hxGAb9KdRcQpLpJiLxTZmPuZmM54dXAVEajSjSD1xSw/ifj7Z?=
 =?us-ascii?Q?I56hhnuZyN4vDlYTjAoM5214qGo0jRByLTVsbX9au8or1kiHt8V6F6oBokZ5?=
 =?us-ascii?Q?EXI5q3xiZX/xYARpEJHWPRoGn85eCBIRjAVJ07ME/wpqquSoUUlVVDoUU6+7?=
 =?us-ascii?Q?uBEFqITwKpaoHjcetDQYIrwIjuOVSRhlykkw7HjkffSN13AU1Y6EOVEi4W8w?=
 =?us-ascii?Q?+eSPb5/3+pwXXISil1IY9b2GARdaj+gE5ZderQaF0ccJbFVkBG2RztO02UVL?=
 =?us-ascii?Q?xTgFIYAvq2Zdodyvxd/pC+uGtjlIiR3XK1ghiWWByBfiZa8W?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D56E2228F74E4D418FB628E3582422C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20ed827-8190-4001-0ef7-08d9be6d68fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 19:18:57.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTtYVH7uZE9kk4ewgue1fOUagPx727dtdf1SXtHll+yiDJxlkuYuRtqpTsJp4hezNnN/tw/wxyEHK/vxeTQr9aUuqXOsUorrADBQiXwhDgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2749
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130118
X-Proofpoint-ORIG-GUID: MW6MBlnY903BHbR7TdKdhcYG-Bif92O2
X-Proofpoint-GUID: MW6MBlnY903BHbR7TdKdhcYG-Bif92O2
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

I like these, but a quick question:

Since the usercopy_abort() calls are all because the offset exceeds the pag=
e
size, is there a reason why you don't specifically state that via the detai=
l
parameter rather than just supply a NULL pointer?

Otherwise for the patch series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Dec 13, 2021, at 7:27 AM, Matthew Wilcox (Oracle) <willy@infradead.org=
> wrote:
>=20
> We must prohibit page boundary crossing for kmap() addresses.
> vmap() addresses are limited by the length of the mapping, and
> compound pages are limited by the size of the page.
>=20
> These should probably all have test cases?
>=20
> v3:
> - Remove a now-unused variable
> v2:
> - Prevent a NULL pointer dereference when a vmalloc-range pointer
>   doesn't have an associated allocation (me)
> - Report better offsets than "0" (Kees)
>=20
>=20
> Matthew Wilcox (Oracle) (3):
>  mm/usercopy: Check kmap addresses properly
>  mm/usercopy: Detect vmalloc overruns
>  mm/usercopy: Detect compound page overruns
>=20
> arch/x86/include/asm/highmem.h   |  1 +
> include/linux/highmem-internal.h | 10 ++++++++
> mm/usercopy.c                    | 43 +++++++++++++++++++++++---------
> 3 files changed, 42 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.33.0


Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C42C4338F
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093006102A
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 08:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhHWI4S (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:56:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41932 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229902AbhHWI4R (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 04:56:17 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TcYF025296;
        Mon, 23 Aug 2021 08:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DJ1/XisWGqKRhiZwhiPRq1JJX75fdd7vik3geyA+xy8=;
 b=UvmCKB/9+QoRkF+oB2fFzOg51J3UalZAxNz9fITCJOgEODqoCpG6bBglCwX8B+IlZ9bj
 sKRJWKPGXMF8tBKRqkOfhojou/kikPLEx8vMHxjjNLAmCEO9mznDcFPI+VhNriaKVBz6
 4sleIsTQfZjGZOqlIOcYdbkCBUTf6itL0mGCcZsqZHOlwbmFwTK1JQrpG5Xm0Eybr52y
 Q1AHl1BSdOffLMJdRsXSw7TsjSIYnY20vSzWf9N5caZh9nCsvJ/g5PwKmeOhYnOmgRcS
 dqHLd4HDutypK4LvYC0pNv5sS0vQA433KUkx8/M9LBWlr/ps+AVeFUD5epnCQd2lZX52 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=DJ1/XisWGqKRhiZwhiPRq1JJX75fdd7vik3geyA+xy8=;
 b=IEVkyWReXc03vL/7IUg4HgjvXQUBhQZZGXNzOPKVUvrpP1sfnVpgJNE9LZr4Cequy+F4
 9h9hbf5FPqZsy29u99iE7Mgnmeq6smWAntms4N1HEHAwcr5rLwY1l+T4mOe6TBxT+u2t
 Jt6AJ4Vu0AQjP7oLkCGy81XQ6swdgy++K6Cnei2QUaMCDh6m/BwBrOGOvHK4OccsCxtw
 c7xJpZswAqoho6StH1N14yR/X52eLvRYdxMLusw2DnM7b8vV8MjryNQWX6TNlEHdHubS
 nxmB5z8i7KtZEY6jmKXGbuhOBcuOSKvbJI9OVcG+2GghHfYnwk08XCzrHY1XbE/3Ld/j EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aktrts099-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 08:55:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17N8fHnV176720;
        Mon, 23 Aug 2021 08:55:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 3ajqhcakn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 08:55:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG6s/41ZDsiBj+DOiLkdk+QXKQTL4r57uFlCAqPL10i0Ictn7qj2td0VuAWhPcLMwg7u3AB14nKW+EL8H3SOIMxGqd1QYO/hoJpdgEtNxtkKZsPaXyhHPcWMgo2sLGAZyvoGdwS8jzHUWHLhpwBbV8R1b7n44+G4+ZLzDNl69kRYgJjw3dCcMg5AIQcZKJqNzHaIezuqhlF2wxwI2iXCZaTL/eBOkUiBWihYLSnxr0hX5li64PEpZlabbQQz2/whxem+2fT0BD/hf1DzF0kuAUvMd7tzoelNVvNfyEWhjW5XtUE9dC/FRAqyr7cc8ByUeAKknuXToz7iXk2AIyFqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ1/XisWGqKRhiZwhiPRq1JJX75fdd7vik3geyA+xy8=;
 b=GjpxDci7lWsMxOzPbPLyee8VuDQwRKFhlYg5J1zGdUAimSQjq1ugnm+cVSmAOLM18iwjC+QOz3gpu4TyRmMrNib3OYIRtm2o2pc8D213Fvs+rfoICTuVZiUkHwdtAgRrPZQ5inMfADmXcn8tSeOwyudTbGW3EMp+mWzUS2twQBHOYRTZV6+yTRL3lNOp0pOlNKhUC7kslHMTiIJ3tp/8AxH0oKj2Nd8yNrp9l4vFDuaM7zmdsWS5PeBD6L/+pc+ZHGX8dx/D5JumzLWDKJAphYuQcuEj1FTrykr5EvhC6lkJSTCU3MV9p+GSHwahntLdL/d+VQWCxY11WRwpIZ6f0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ1/XisWGqKRhiZwhiPRq1JJX75fdd7vik3geyA+xy8=;
 b=WMx61YMPAr9pSuUteKwp50YxpbUXzVIwjOOah59UP2WZWpbc31o1TfhPEjkZOig1/HhB97ykq35cXklR0fENBXsQvGDBih4GydDHRGfdm6zVxC4YB7rISUPOHYduVxo7GLLQVV0W/XxB5rKpq17OVMetIs0v7STQBio1DSjtSKE=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5459.namprd10.prod.outlook.com
 (2603:10b6:5:359::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 08:55:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 08:55:13 +0000
Date:   Mon, 23 Aug 2021 11:54:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] staging/rtl8192u: Avoid CamelCase in names of
 variables
Message-ID: <20210823085455.GJ1931@kadam>
References: <20210822142820.5109-1-len.baker@gmx.com>
 <20210822142820.5109-2-len.baker@gmx.com>
 <202108220759.E6D94F75D@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108220759.E6D94F75D@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 08:55:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feb24f0e-9207-470f-5f4b-08d96613b7f9
X-MS-TrafficTypeDiagnostic: CO6PR10MB5459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB54590F7C6549D337C9B25E1D8EC49@CO6PR10MB5459.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVldPx3lfDgylreTzGhlzz6gG6IZRrG0l/P+cjk0mNI31G4yGpR0tAVPggr1xtp4BBb6PPG+hOynrN1VqYEe0Ss/wb5Ma3Hn9S+RI1D051CqdUPhQ59GIJfWpxyCjQmDZSUNdXOt0GanU5E7r6y7m8AUt+no4B4XHl0WowFEhzVc/PlC1FKMYuxB1xGdtWcbqJe5dnde9ECk8H5hpzKf9T12IG02w93dE3hyhwuRpIK0QUH4ZcrRX8Hw+zsS0vMxSisND4XBif64uuGbAcuiBSXIwWi//QeDinyyu/bMaLa0STbNzSqQZu9Ps2qeF+kfksC6afWfiNEcW3DyeI96ZKOFfQWGv89fXY08yCD8psV3x4mYE7n7BHYBpTR0AzRhyWKVAYB8Egkgt2XdSm5H/TxEGyjQGIenoM+z7JyPVTIDh/IUsqx879civKyYrknQf/LFZtV+iXbnd8vijl63opLtN3577UwiW88kWNpICOCu2Wth2EnoZYXRsuB3gZ2vddFpufRrljjHoPPoWFsSYCvn3HZIseoMLl0yq/HQwo4oB9UUE6PBLwgAg9aQn/E3vr5DmY8C5In7esxfohhh21eaDcrzlkGioRP9XB+KqPdr8I6c/86eGT1sI6sLBzFYY3P159eEvdrbhm6qH0tVjKVK6nEvuaVytOkdVE4E7X272+PhrPup3QBl42vo5Vz6MyEWsY4MZ9cHCu1ljhk0zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39860400002)(346002)(366004)(33716001)(4326008)(6496006)(54906003)(186003)(66476007)(66556008)(33656002)(66946007)(9686003)(6916009)(8676002)(26005)(83380400001)(55016002)(38350700002)(9576002)(52116002)(38100700002)(4744005)(44832011)(956004)(478600001)(8936002)(1076003)(86362001)(6666004)(2906002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jUF+8ZzdWVAxt5c2Qr3jkphXKAYIzmGivh0DLTIbKJCKpHLARFQnFwror3gP?=
 =?us-ascii?Q?0pxpJVMKNduLNdVtgXIVY/nXPXT+/0lXUsp0XeOY5b+FOyaNPrulbF72/wH4?=
 =?us-ascii?Q?cAwol2e6++G1KfMAsWhv9WLoWE7l/ezMJHqX/pgc6BUa8CNE3gPLalbKw445?=
 =?us-ascii?Q?oF79KkChKn59RNJ8sfAYOVleBZwpTgHnl6LVSHaZgfHLE3rN08asxiTg8iYE?=
 =?us-ascii?Q?pRf5UqCzjUcfFPw67Iv0BzxSSvnqUOehoHMKpZS/d0xiIm7Kv2jyUEeSHHVn?=
 =?us-ascii?Q?KLSmKj/swY0fXvxF0biQoWSeeMsvAve0cx9zVnoGDmw0COlV+w7HwxBODNIX?=
 =?us-ascii?Q?C/x1Y0lc0eUs0cnXRPM1F7SeAacPTQYtusmW2tpXzWimFpvdt+cT2DIOjdYA?=
 =?us-ascii?Q?xc24Gm/NOFU0SRAdvDxxYJ/3YOSvvthyi3/+0+EjQNs4W4A5oWda/annPMAH?=
 =?us-ascii?Q?AOuj93L1H/H43zb1kxN2ourTATNMU2kJWd/oEY8s+EhG+ejMYTd+N3laO+LU?=
 =?us-ascii?Q?yqXryY3DMvNILEygCD20tu4tF/J1s4xa3mp8eI/PHjbHjklYnolfNdfF6YkF?=
 =?us-ascii?Q?u/YfqGFGkdLxb55NcoP0EVVb57tee+UzOVGbn8Y1RCqgasP0p2b13uaKGlrJ?=
 =?us-ascii?Q?QavcGyqGAXUhBQ1fPyA4PPxOzhnVN9gA0qUVEPLMzv2xlnacat4SXNGvIwat?=
 =?us-ascii?Q?3wARAZrzn+RPe82bJwAxlNlHWJJbp2ATb57sOHuYPQMMDlfm6BVfeADON+gG?=
 =?us-ascii?Q?YBrIxwjMYqTeG/N0XzMvompSzUsikNDx5WMLMDGJHfUeGbZGzP2JLr6sW9Ic?=
 =?us-ascii?Q?r1hZxEREb6+l+0N4X7XwQfevyhGJ1HMRSKLPIYbz3aKCmxv1lwjE1CysGGUU?=
 =?us-ascii?Q?VAvW2YSVFdOcS1wvxh+KDYP945J54J7jcjiqfoxtW5LU2pq68gBBCCvp+Xts?=
 =?us-ascii?Q?TjsyrEkwcMCbkwJ5BHLnulOOjnBIC3ypF1yJSIijxrqaDGuhN/7dHeWbmy+X?=
 =?us-ascii?Q?HrSlgw5Fa0xIXQRzgMY3QL2Iz+k8wD29kjFwvz4xwmls1bMRHUog8r+WXWGF?=
 =?us-ascii?Q?1PeFlDmxhKiFtgEBqM2NbYjslzon5RUKSa1bXbwd2zffi1ugMOtXoXMz9bVp?=
 =?us-ascii?Q?sWGXnyxG8OJ7X3ClCEUixdsit48l0BSWDEHoUdpGXUWsM4tII8+E2gj9tpn7?=
 =?us-ascii?Q?OgsStDWlsb9zBS75ZVr4sB66sm/0GEU8TTjIF/Td6rGLelbWTzTdfLhSA3Ey?=
 =?us-ascii?Q?2hAyanPBOUvtR/mwMmKmNRZBMCCu+nY5LGvIcdpEXUKWXGXSdb26fpk8P58+?=
 =?us-ascii?Q?ZqszQcKVZj+H9xaBORp9TLKJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb24f0e-9207-470f-5f4b-08d96613b7f9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:55:13.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Jv2yK1pHpLxk+VE0nfrkVj3RVciF1OPnM9U+7z3MaMfBZWuwHU0b5xg3rozK8Va030luS48mTmR5jq0NRdpp5nxgrpJQxTjjqe/Ub+F/wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5459
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230057
X-Proofpoint-GUID: gib2emip6ahhxRKAmzb1SLTzQ0fBL4s-
X-Proofpoint-ORIG-GUID: gib2emip6ahhxRKAmzb1SLTzQ0fBL4s-
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Aug 22, 2021 at 08:02:14AM -0700, Kees Cook wrote:
> On Sun, Aug 22, 2021 at 04:28:19PM +0200, Len Baker wrote:
> > Avoid CameCase in the names of all local variables inside the function
> > rtl8192_phy_SwChnlStepByStep().
> 
> This mixes decamelization with some (minor) logic changes (moving
> initializations earlier). I'd normally do this kind of thing with a sed
> script and not touch anything else, so that the results can be compared
> against the sed command. And I'd include the sed command in the commit
> log.

Yep.  Absolutely verboten on staging.

> 
> I'm actually not sure what the norm is in the kernel for doing
> decamelization -- should the entire driver get decamelized at once,
> instead of just one function at a time? Greg, do you have an opinion
> here?

It doesn't matter.  One function at a time is fine.  So long as it's not
too long to review.

regards,
dan carpenter


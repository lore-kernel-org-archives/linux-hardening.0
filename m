Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F0C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 04:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE256113A
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 04:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhIJEv6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 00:51:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9242 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhIJEv5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 00:51:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189LpLRv005251;
        Fri, 10 Sep 2021 04:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HW35OZ+ON0etrRt66ewogK+6ZGZQWgAsgRchlK+ZtBU=;
 b=KNcuXqXVdhKFHogSRj+hpnSPUlLvDiAbHUPsF9Sg3Yp9uXWfuLdvMc0VHU6Kel5N72Y8
 UEoXQuZJskaHKzPX7xtjvJb/QzEcQEwb2npErDpj88XnZC0LPguRN1KgHZETqdhYKwwR
 RfODY9QH8gTFHj3uqQRtcX5N9GYQMZlTcqBcwuj0CeSTwZ4nJCx4IL435Qvm6AOUk2fN
 XyrYvMusUU814d9Gsxpimgm1SJTL/OqIVxdJai2iRQdgmsMzdCq4UQT/Hhaq0D/FrcTo
 A2btY3Pcwa+kebquVyl0KRPrR9nrAHVEI9/lxY5CS6ThHhbKba9zGoDMOQhAbMGpH7uG uA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=HW35OZ+ON0etrRt66ewogK+6ZGZQWgAsgRchlK+ZtBU=;
 b=tuT+9paEOAv784FrTJ5nJ1TjXx8DsImX20hlBWfBjkgLLpn2/LLieNgPTvTLwbdu8HIp
 r4daWX8zyuM1/9OUeQjNsPJI/OnJ0c9rJkPLFjnbqRs+5+wtgTuBroXSW95ftgqrU8rN
 1ZGX4dlGnziaE9uHHYzOIh9inW0aw+R8RceR2BxfN/IsBaQD8m7kHowqI6xAXp9BYlUF
 lIr+y5C2vMmeccG40XwU9tNabrEhP01/5ENcf5YIRHPLEDpL5GkL+zpfnfh/ARoB2e6p
 63c8Ol1QMVp2upccsZbflL3ZCruiyxDS/NRRMjR72vLj7UJKOiPo+4KpbdmMqGZJ3b9D qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aytj5gnu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 04:50:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18A4eumU093481;
        Fri, 10 Sep 2021 04:50:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 3aytfcwe18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 04:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXqGeNxbjRfHfLE1DcZHod0OAXTJYviXFYHNLp+YTBDTarONFi8MIg7Pf/KVzLd8i4onYb5Pu4MB2wm57jgcThbUVzvD6ABumk0DRB2LsWml1hiI+HOOPLaH0XhRrUEnDlB5HTYs3H6Sc4DCz/khUGIgNJ0DcvoYNfly2tXclaVwa5cScNqTNGmK76kFznvQafIWDHY/uXxRk2lCXeIV75dEp3+uJHUuCuBQ1UAQG2dJxkyLGyu5JpVYnY1cJg7rgVsl8GGdvdxAjVwDUc4OChjhm3tyXkB4rkxLnPfO/yIROeoo4beUinLVwpW5XnVaimfOfRPOrU0WLAg9rfnbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HW35OZ+ON0etrRt66ewogK+6ZGZQWgAsgRchlK+ZtBU=;
 b=DO5FWMzLG7VIKxC/XV5QIDBO+xNfuObbApnolcxQMWQcejax03f+e4RryjwE3wErxB9h1hcYDc9sTm8Dl4Wd/AOBdsciMpXkQRe8aBGOgIqi87Q+r5WJdD5S6+C1ainNAtsNbHj6bnFyBU0DgFEAo80oZH0CjTD/0St8b52Bv7r4tNHJp/nBV9bs/MT/gC4FABblY9rvjkXKIJrkSgKYBLQmELM+N5ID1LxFAEaMVoFyHRWy7begsP/YgrjL0u78FDO96nBtOd1Jj9ORwlpJX4HPnVaVGpCUev6m9FA5agIwPxZ/Gekn1vLlqHsICLspV8OT+Sb3Pe2lS/ceBfw5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW35OZ+ON0etrRt66ewogK+6ZGZQWgAsgRchlK+ZtBU=;
 b=JuKOwsw5MjB2hAOXEkyryqv1c2DZOed3KPkvUNgiktSfPThUA6MyIjHptStzGkJPjeJRA4i+UkYThoV/6UOfIGheXDB/iZWAvrwNDUsOYY9pPjGRcvsN0l2DlfRFn/SIIFyjOe8YJlTGiXGs0pkko9g+7eCtkaig0fysygpa+D4=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Fri, 10 Sep
 2021 04:50:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 04:50:27 +0000
Date:   Fri, 10 Sep 2021 07:50:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Message-ID: <20210910045010.GO1935@kadam>
References: <20210909161409.2250920-1-keescook@chromium.org>
 <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
 <202109091549.FF8E0C61E2@keescook>
 <20210909161109.14b147628de07ed7c20d84ae@linux-foundation.org>
 <202109091849.53C9A8AD@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109091849.53C9A8AD@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 04:50:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bbd1449-a3ce-4a9f-d512-08d974168218
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45619EE40B95910FF0D137338ED69@CO1PR10MB4561.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUoTaDhAkiZSg6QusrH+eQDgCK0iQJIkkPn71DATWB7zaiIFuabI4e1xWmhB/8P19J5g04HK0XnM2Q/M9s9t9beqyAjHokvsvHN4N/3fBthl57ngpHu87udW+NvN6mxs7ujqy46VR4dldeuzByaqcWphaoWt8SFElMIcYXrvosdf+x10GFGaO3eoy4xnrIE7sZQZb/w8ezzaMxcMFQjoijPVUNqTMziVEJDFpNWzR89UnmmD+khDtYACOF00Ja/QWcEwUsjgj3Rsqttn89UqXlKlvqCr2c/orRnAL5R3LmRLoWgrahBqhpuyF3nARkpKYQ7hi+YOjZNqDgqf6AqxAzv27LAJf+NZszBPqmp31r+vMTSa7SFZGLZYrnNqzFgGKJM/dLhpiEHzUrvl8yGO6TJcP2aCbVp94VAKyy3+8n7aY8iTQjNEGZAXvo3bq7o1/FMuIeA1Ezu8cjfrG3F2/6rOukhnwzVHpK5cVDgn0DxntslGOmM56Yx0dB0exFscKwAZ5AUIMCc6A+mHUkhs4SareKrK2f9Xh/sGKXor3/O0qH9c3CZixV1iVmLZaFgm6cEyhPQpXqG8YwBaPX26QUTaytd/NNP41t8vnayO/8kHyRu08hlPgUqeVRvr26IwkYGOwWh8C+D8qBVGFguRiYh/xSCqezWSyoNrh6Ncd969xW/NoFmof3X+fYChAEgFI0t1nPhbFQcqsXjmURdZrOIY8DD0nOW2j0icKizO6EXIngL9EhmdSyCwpypvETM5de7hAVPgVr3WBFwShBFEueJar9fbrIlnWvKX1ADGjYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(39860400002)(366004)(55016002)(33656002)(5660300002)(83380400001)(6916009)(86362001)(4326008)(52116002)(8936002)(9686003)(6496006)(9576002)(8676002)(38350700002)(38100700002)(2906002)(33716001)(6666004)(26005)(7416002)(956004)(966005)(66946007)(54906003)(44832011)(316002)(66476007)(66556008)(1076003)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UaEzzUx6t7e88guowYqZKQXw++kdtASQp7E1JwO9htgZM/rngclPg8scry0Q?=
 =?us-ascii?Q?Nzbb4UbdhrHHLDuFKlVQ7e5ZLgY4mTnuiQuvoLsMaXqdfF41Y67SherCMru/?=
 =?us-ascii?Q?mzM8WyoF5yrmIC5a4YgsjeKaGtMuVJecYw9SkTLQ1gYGEVFJImc5cGFcfuWH?=
 =?us-ascii?Q?TuDPTalpVL2PRSV8hHRGFCbHzAaj2xcky/0PiALb5hJFfXkSDxtLqP2Dvb+L?=
 =?us-ascii?Q?p9YuaaARboux1VfNKpTdjIJ4GJTxsrUMZt9ULF+ieSc4bch7jDdenXb/JJiX?=
 =?us-ascii?Q?jI2jFmg2QHmUwe0N6Ope62anxqN62G/Aqbt3yh0QwQJz2d3Nrq8jo0/O8+wu?=
 =?us-ascii?Q?MkvkSFFn9wPBEkGrnqLEhCNz1w7XYS0YgIJZeesI/z0+uvyU4BKxQ6hBM/FQ?=
 =?us-ascii?Q?qaoSvUEQ25C0GoLLjXORfW8ejC9zhnHEaQ8cNv/5YDr3v0ZjNbXUCNWdQwXY?=
 =?us-ascii?Q?1oRHiUs/8SYTntgA1OPp37DI4676ikkCa5tOJUkAhQgbW57HOfC+CA2qqv5q?=
 =?us-ascii?Q?3Bq4sgV8fueQTCsNwzK9EH5WizAAzBVqfatk4ost4Cb/NsjnWMFpTiacNYSy?=
 =?us-ascii?Q?7aWW/nufvhs8ARbGMRDtI2luvmc3Qi/4Zsap0QLeencNe0H+WP0tf/lv0CFJ?=
 =?us-ascii?Q?HuqA7ehIOUoly3/PdYjwvXTlykEHgdVJaS6t+J9lGrYCwAs9eqBUUlPIZA1G?=
 =?us-ascii?Q?ehY4mbxF6Msf+huA+L0dHB5HdXEm7A4NW/ZgliCEzT53sNntTvdVmoT6nr1X?=
 =?us-ascii?Q?8qsc6WeQ+s5C25EbDyUcKp1ggM0t2YGDx+cZMQmiKxPTWtCpklrjTNINjq0C?=
 =?us-ascii?Q?0msLcW91c9BwxBtfwl/RgZni+4ntEAiWukCXnTfHxayNtC0zQV9b/Fym1b/g?=
 =?us-ascii?Q?jsyvcrzbkmAdx/eGyAt4kwI1xHVumagNoW0S+Os17w3JoiO61vToTLmt+AoG?=
 =?us-ascii?Q?EZyn2a/httfaYNp0KPZUBnPLVk3b1YlWC/mseqGFEQM9ufMh5R6o2ZV/ati1?=
 =?us-ascii?Q?0cX1253vN8AsR6yMsgqAQz/sPyk50qEymN5ypRwBIg46V0okqBPPVXg8CubR?=
 =?us-ascii?Q?UyZSVTptn0ts+NNLzMCbOBeuy29xWl9wCvEJFcqsM5I6+F20cfcoLCND5xhm?=
 =?us-ascii?Q?qxPJTDSqSwABye1cikkxN5MZIF7fD3POYs5Ma5k03WFHxi2UwRYOIjwaidE8?=
 =?us-ascii?Q?bkYpehMq3534t2Mp7MmrC1QWGkHkwooah8TxrGXzLW3JZzU6Hm+22IhSI88T?=
 =?us-ascii?Q?tdAr9ZGgRYf+1hNzNnepwQ4JjvPBThUWSZrTX3pgrBpxyvXvrSl3DuUii6jK?=
 =?us-ascii?Q?fwFV3U48MfmFpvkUWk4eK7Lk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbd1449-a3ce-4a9f-d512-08d974168218
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 04:50:27.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFxAm2jix5lzwTS/C+ysl1KSzQjzOHwmMBxS3YpcCgnnO/xUU6QQH7Vcke46s3ipvXYAf4b/f2y0gXRYCLCicdqPyFHn8tIt/AlCO2X5ul4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100027
X-Proofpoint-GUID: hUW7RFsTO2VhspaRjLu4WXyNTMGmrTre
X-Proofpoint-ORIG-GUID: hUW7RFsTO2VhspaRjLu4WXyNTMGmrTre
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 09, 2021 at 06:52:27PM -0700, Kees Cook wrote:
> On Thu, Sep 09, 2021 at 04:11:09PM -0700, Andrew Morton wrote:
> > On Thu, 9 Sep 2021 15:51:23 -0700 Kees Cook <keescook@chromium.org> wrote:
> > 
> > > > That's an "error", not a warning.  Or is this thanks to the new -Werror?
> > > 
> > > This is a "regular" error (__bad_copy_to() uses __compiletime_error()).
> > > 
> > > > Either way, I'm inclined to cc:stable on this, because use of gcc-9 on
> > > > older kernels will be a common thing down the ages.
> > > > 
> > > > If it's really an "error" on non-Werror kernels then definitely cc:stable.
> > > 
> > > I would expect that as only being needed if __alloc_size was backported
> > > to -stable, which seems unlikely.
> > 
> > Ah.  Changelog didn't tell me that it's an __alloc_size thing.
> 
> Er, it's in the Subject, but I guess I could repeat it?
> 

This is how the email looks like to Andrew.

https://sylpheed.sraoss.jp/images/sylpheed2-mainwindow.png

Try to find the subject in that nonsense.  Same for everyone else on
email as well.

https://marc.info/?l=linux-kernel&m=163120404328790&w=2

I only either read the subject or the body of the commit message and
never both.  :P

regards,
dan carpenter


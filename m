Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1C0C4743C
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A796112D
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 14:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFWOfJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Jun 2021 10:35:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54354 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWOfJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Jun 2021 10:35:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NEVXF9015420;
        Wed, 23 Jun 2021 14:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WKKbL19LgTM8JEBYZQwWfrJy7ycEQhoEDb7hQ0kxAvo=;
 b=l/uk8PaMHD2kjQzdybi/702V9xPLabOFO3ILTymJNRy2ApHseAOOy4caB9NUeq4rKA7Y
 4VdQto6GwPBFOpqlBLxi30haWn1dnAzf35vtKjP3Dowa/Unvz+nJUMN4gjmsnJ9whVrp
 muxHquCyx2xD/Cb9i+jIiSenLw6T/b5LGVUsolmzTb/cMGGXILN5Q5w5XFu2wCirQtKe
 IUwZsQxFceJt8c3dBcWnTIGW14Rgsfi/dY+vRfZPV4qhDCMXP80MsfBqc7RRG0YCvf6G
 kEf+OQj5Ha30eV2FIKXwuzEKzOC+P3wNQqAVcMD/GbzXgSWkFNBRofF/vRxneBIl0oTX oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39c634r4e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 14:32:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15NEVVi0093442;
        Wed, 23 Jun 2021 14:32:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3020.oracle.com with ESMTP id 3998d96rea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 14:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi3dtYrNHRtVhx6NkfypOyUnobgMm134pT+cExAVjRLJwbq34iSpCnFaPX5X8z3UEgqa07A6++NjRxk5hyyI/WYi1iMk9yUEfAiA68rxU9wo3GCOyzmyFyzxYd/I2Fsl3qI3KTuWda6zIXcRKGWWORb9gfS9gOTP8SIeVRkiBNW3nd714hz+ml2B2txFBj82Z44EzHr+gC3zs+M6anqn6ztz7PCFYZIjYrF/ymGwHEkASVvE3DaT90i+FC2LXg1UaSRfpWSd4UlCjanz8h3FN/zowctVYGCyVTmnAIwXiiYHoCfjpiIkJG5k6Ds8nb5G38BeC2tHhX9MvT+pWKgPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKKbL19LgTM8JEBYZQwWfrJy7ycEQhoEDb7hQ0kxAvo=;
 b=ldpVGE6ILOV42m3ZpdXjxb0TFjUfzkJJ8M7gNGjWg1cserd3YUFFVPR0BAdvCjyN3N8TjUIDqB2QevYD1q9qTrFWIq/yc1ab/b8shpu7+xNlzVLaUqPdIgOEkzAJhnRXt9fQb9rQTqSe+P2j8TgOllRRp4StRYHIdozx4fuWJZ0MX2iec4FGiLmLHFREBoVc0ADJ2rqmp350jVb5ntIxcktArQWX1GTI14WWCIIHw93kzbnIUtQerVpY+K9LBH3nQ59hyiw+XY4fEb+XAQDI6BnT07TWQLyhijm+pMi27a37L8GHXn/W4R8+1cmlHMJzCuCu1bCnfw9vMOcZH+HUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKKbL19LgTM8JEBYZQwWfrJy7ycEQhoEDb7hQ0kxAvo=;
 b=InlxvtCF+4h3FNs2XrBvwTk/+subgnTyOmYYjlGyWQVM1MMFsofnl1dJO0jAnXGGRr4ohcIcXLxCI8Qp2EmHeyC5WV+sxN18Cpguy3r+ZAdLmaPFWJeQM9UQO/0ASWO/mAZrHvRHNg3/LmHRQDaxjjW+53XKfzc1LiEPxDBdGpM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 14:32:38 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::e8b2:b3ae:8523:98ca]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::e8b2:b3ae:8523:98ca%2]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 14:32:38 +0000
Subject: Re: [PATCH] jfs: Avoid field-overflowing memcpy()
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-hardening@vger.kernel.org
References: <20210621232322.1871799-1-keescook@chromium.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <c623e29a-a38d-c7f8-3035-61d1ad37f43b@oracle.com>
Date:   Wed, 23 Jun 2021 09:32:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210621232322.1871799-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [68.201.65.98]
X-ClientProxiedBy: SA9PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:21::33) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.190] (68.201.65.98) by SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Wed, 23 Jun 2021 14:32:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8958a4f5-2468-4053-a0c3-08d93653c053
X-MS-TrafficTypeDiagnostic: CH2PR10MB4277:
X-Microsoft-Antispam-PRVS: <CH2PR10MB4277F5BB592DF6398EE59D9487089@CH2PR10MB4277.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xV7f9lnih8eJ4tnI1G9uvEQmgyf/Eu5HsxnmrY0gCsbqgE2eLpf2fXdc5EBfnf9GJOQnsdut5/q3gad7sl2vdg3xHbLBPUhVZHd0xzsDTp3JokKjqsIidwIjOoz/fcvskO5lUcrqQ6j2AIryoODr65uRya8bItUM5WaCfcKIHiadUitlXVHyq0zj91j5uRrdui1845uxqA4l+ME6eh5KBDA/R1UeqH8JDIaVvt1SOwSd3uVoon4TUlHwUdck2sunrf71bo/k64GSf8v3vx5PZQMfgVAXRJtfwxTXJ4pNftYEkZWbbBYD7L8HWAsAfO0z/uc+0rkY/C4/Rs9C75cnN8P9Ewgj5auVuxo+QJGRsVzK/cmQrgC+qk5CSKS1iyLseczltb106pqlgQen1v9f4pc2BrYtNR6imwxuIem/+QHjvfaozlXD7x4HAM5/K7kjHvhKGUf9FdmBWp4QlIq1wQlyj1Tgc9L3pSR+ib819GemScHyTZGGZ7puOKpcM0DeTOYHiFHpwbdUnwAU+/e7aUHOl8UW0dsE9Y4whhWHbklxrwFOWJm81QSSUkRhmUNM1zEg/od9Xfx2RhlG3PZGiYQ8Ed9jzPjiOSrfZqcwwRTXtW5r72SmZDT6z3Rhufgza7fJJwYdwvqRbgvMfdQvUGKA1WHDrdJ1pAN6ipyyTaWTq3lm5jEmpicXP7yFmXEN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39860400002)(86362001)(31686004)(31696002)(38100700002)(53546011)(186003)(36756003)(4326008)(16526019)(16576012)(6916009)(2906002)(478600001)(83380400001)(26005)(6486002)(316002)(44832011)(66556008)(66476007)(2616005)(956004)(66946007)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZrNzUrNnNvR3dnak1ZRGJXK2VhMlVaT1phWVdEL3RQQ3FIcFFQOFJKYlRz?=
 =?utf-8?B?NDRlWml5d0RvRytwMkhYU1VCSnhqRHlGeDFSV0Zac0pkYThaakpmd2IwdEpj?=
 =?utf-8?B?RmVMR3Fab3hJUWkzMWRsZEo0NUNlUDI0Vis3NW1hak5rU1BCTWo4OFlwait6?=
 =?utf-8?B?L0dlN3hDZlQweWVXWnl1b0hIMitCeWlPNU1GTndFN1ltMTBBNkt6d0NlWjli?=
 =?utf-8?B?Q3ZmOVFmc1U5dDFjNFVMVHJxRUNNRVZicGk3dDdRSitlUm9UdzFCVnkwMDVj?=
 =?utf-8?B?ZzBnRWl2c0NxdzVJbWpTRlE1RmJ1bnpFYjZKSHE1RUpCMXBGZU9GT0FQYmxq?=
 =?utf-8?B?MjkvWEN1c2FPZnRMV1JDWFNQamtKcEhmSVFpamQxRVdwdXo0a0xOYWFVK0Np?=
 =?utf-8?B?MVk4TG9WTjN4QkNLc0Y3S0JoR2RDTkN5bnFkb2ZYSUJkd1FtNjhjMHA1OUVV?=
 =?utf-8?B?R1F5WUtJekpnd1d3eWRMMk5penUvRVhFUVJISTVpNTdkbXBadkR2ZUZJQ3dZ?=
 =?utf-8?B?VGlTbytkRGd2ci85Y2daZWFhd0IxeUNvT0VSL2d4ZkkzM0psQVFWbHNIcVFx?=
 =?utf-8?B?ak9aUVhQSUM2bDhrRFJCNDlaeVV1N2J6TXBVcGtZcElocHBpVVVUWTRhcW5M?=
 =?utf-8?B?eEkwY1BXTXgrMlhCNmRqYWRsVEk1VzREeGJNVjNHU1ZveGFmcUZWNlpxblU0?=
 =?utf-8?B?bXFBdWJvRE15bFJCYnV6ZFBWMGJXQUlZVG1RYXBBaUlpakp4MVRhZjF1MGdn?=
 =?utf-8?B?NllYQmVtckZzemt0OGVEajR3cElJNDVIMWw3S3VKVVpjd0Y2WWxkOVFaWkxs?=
 =?utf-8?B?WXdFY1lNcjJDNHBiZ2svRWNoYlZMa3hpbTV5ODB5UGt4MnEvRkVBSzF5aTUw?=
 =?utf-8?B?MnNTdTdGanAxN0NyUlMzM1U3SVpSeGNzeU1zazFCTWxLSVNET2U2ZmcxV3Zj?=
 =?utf-8?B?aS8yNFBtdi8xWnNyYlZzMDI0bEZRYVp0bGZ3Y1N2N0FFdHJqMWxZMlFRNU50?=
 =?utf-8?B?ZW1aRWlMZEppVEwrNEt1UDkzclB6VXVaaXh3WjBpVFVZTys5em8wRitQcWdh?=
 =?utf-8?B?L3FiTlJLZlFRaGJ2R3ZDRWtLWTVreVVsVEdNajA5b1YrckdKS1RWTlkrckg1?=
 =?utf-8?B?WEx3OTJrbnZiM01yZDNUZEU4cmxsUldRcW54cndnTDJXdnppREFQbk5zYUI3?=
 =?utf-8?B?Rk1CY2U3aXp6T244Zm85aHFKNGtYTnMvcXVzUEZMN3RDdnVLeTBQV2U2cFpL?=
 =?utf-8?B?K0JtUFJBTmdibGd1Njh1Tll1djcvcHBUZEo1MGxPT3BUZVhoeDlzT2czaThC?=
 =?utf-8?B?eDAxSDBRNTdtSnhkZDZqcW0vODl5N3lZL3NkZXA2dDN6RUhodnA1UHhMT214?=
 =?utf-8?B?RldIalJlQlUwa1dVVHJQbkdjb3RhVHMvL2ZFaFFQVEJQNGlTaHRPb2NiLzFY?=
 =?utf-8?B?aUN4b0Rmeno0T2FoQjlmd2luY1hHdEtvakEwcU4rZ1VZMWttdWNDUGozeEhl?=
 =?utf-8?B?czRiZTdpY2RUQzNZTG1Bajh5ay9IKzRGaDVGdXdPcXVRVEVKVG00TlNaRVEy?=
 =?utf-8?B?UlYzbFNaK3lUaURQZEZJVU1SdEpjUUdjKzFvSDVOS0k2ejZad3ovZndnV3JO?=
 =?utf-8?B?eHFQV242ZmE5ZndlR2JoWlllUjFxb2hmLzRub1hRanRVREZBUS9QRVBxWDJF?=
 =?utf-8?B?TjFtQXQxZStRS21FdGhaQ2ZDZFF2bkx0V1JXRjJyTUNsOXZlYXNnc2w3QzBz?=
 =?utf-8?Q?ejf9wICL69JF/IA8b05FPL4aaj8stpgGHe/Qt1+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8958a4f5-2468-4053-a0c3-08d93653c053
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 14:32:38.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxkFQq5GkQy8dQ4+WfFd6rQO31fgUlCDwYSNSq4SJ1+mKhwlho5SwSQgZ7OVTquZ8Y+AUnFeqa0EjMnIJ1jl7lQBc4r1Jf7vlzHn3AhTxHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10024 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106230084
X-Proofpoint-ORIG-GUID: 9gUw4hbkUBgtvLTUcuMlBqziHeYY7-YM
X-Proofpoint-GUID: 9gUw4hbkUBgtvLTUcuMlBqziHeYY7-YM
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 6/21/21 6:23 PM, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field array bounds checking for memcpy(), memmove(), and memset(),
> avoid intentionally writing across neighboring fields.
> 
> Introduce more unions to cover the full inline data section, so that the
> entire 256 bytes can be addressed by memcpy() without thinking it is
> crossing field boundaries. Additionally adjusts dir memcpy() to use
> existing union names to get the same coverage.

This all makes sense and looks reasonable. I'll push it to -next.

Thanks,
Shaggy

> 
> diffoscope shows there are no binary differences before/after excepting
> the name of the initcall, which is line number based:
> 
> $ diffoscope --exclude-directory-metadata yes before/fs after/fs
> --- before/fs
> +++ after/fs
> │   --- before/fs/jfs
> ├── +++ after/fs/jfs
> │ │   --- before/fs/jfs/super.o
> │ ├── +++ after/fs/jfs/super.o
> │ │ ├── readelf --wide --symbols {}
> │ │ │ @@ -2,15 +2,15 @@
> │ │ │  Symbol table '.symtab' contains 158 entries:
> │ │ │     Num:    Value          Size Type    Bind   Vis      Ndx Name
> ...
> │ │ │ -     5: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT    6 __initcall__kmod_jfs__319_1049_ini
> t_jfs_fs6
> │ │ │ +     5: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT    6 __initcall__kmod_jfs__319_1050_ini
> t_jfs_fs6
> ...
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   fs/jfs/jfs_dinode.h | 14 ++++++++++----
>   fs/jfs/jfs_imap.c   |  4 ++--
>   fs/jfs/jfs_incore.h | 12 ++++++++++--
>   fs/jfs/super.c      |  3 ++-
>   4 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dinode.h b/fs/jfs/jfs_dinode.h
> index d6af79e94263..6b231d0d0071 100644
> --- a/fs/jfs/jfs_dinode.h
> +++ b/fs/jfs/jfs_dinode.h
> @@ -101,7 +101,6 @@ struct dinode {
>   					u8 unused[16];	/* 16: */
>   					dxd_t _dxd;	/* 16: */
>   					union {
> -						__le32 _rdev;	/* 4: */
>   						/*
>   						 * The fast symlink area
>   						 * is expected to overflow
> @@ -109,9 +108,15 @@ struct dinode {
>   						 * needed (which will clear
>   						 * INLINEEA).
>   						 */
> -						u8 _fastsymlink[128];
> -					} _u;
> -					u8 _inlineea[128];
> +						struct {
> +							union {
> +								__le32 _rdev;	/* 4: */
> +								u8 _fastsymlink[128];
> +							} _u;
> +							u8 _inlineea[128];
> +						};
> +						u8 _inline_all[256];
> +					};
>   				} _special;
>   			} _u2;
>   		} _file;
> @@ -122,6 +127,7 @@ struct dinode {
>   #define di_rdev		u._file._u2._special._u._rdev
>   #define di_fastsymlink	u._file._u2._special._u._fastsymlink
>   #define di_inlineea	u._file._u2._special._inlineea
> +#define di_inline_all	u._file._u2._special._inline_all
>   	} u;
>   };
>   
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 937ca07b58b1..4df3f222c35c 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -763,7 +763,7 @@ int diWrite(tid_t tid, struct inode *ip)
>   		lv = & dilinelock->lv[dilinelock->index];
>   		lv->offset = (dioffset + 2 * 128) >> L2INODESLOTSIZE;
>   		lv->length = 2;
> -		memcpy(&dp->di_fastsymlink, jfs_ip->i_inline, IDATASIZE);
> +		memcpy(&dp->di_inline_all, jfs_ip->i_inline_all, IDATASIZE);
>   		dilinelock->index++;
>   	}
>   	/*
> @@ -3084,7 +3084,7 @@ static int copy_from_dinode(struct dinode * dip, struct inode *ip)
>   	}
>   
>   	if (S_ISDIR(ip->i_mode)) {
> -		memcpy(&jfs_ip->i_dirtable, &dip->di_dirtable, 384);
> +		memcpy(&jfs_ip->u.dir, &dip->u._dir, 384);
>   	} else if (S_ISREG(ip->i_mode) || S_ISLNK(ip->i_mode)) {
>   		memcpy(&jfs_ip->i_xtroot, &dip->di_xtroot, 288);
>   	} else
> diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
> index a466ec41cfbb..721def69e732 100644
> --- a/fs/jfs/jfs_incore.h
> +++ b/fs/jfs/jfs_incore.h
> @@ -77,11 +77,18 @@ struct jfs_inode_info {
>   			unchar _unused[16];	/* 16: */
>   			dxd_t _dxd;		/* 16: */
>   			/* _inline may overflow into _inline_ea when needed */
> -			unchar _inline[128];	/* 128: inline symlink */
>   			/* _inline_ea may overlay the last part of
>   			 * file._xtroot if maxentry = XTROOTINITSLOT
>   			 */
> -			unchar _inline_ea[128];	/* 128: inline extended attr */
> +			union {
> +				struct {
> +					/* 128: inline symlink */
> +					unchar _inline[128];
> +					/* 128: inline extended attr */
> +					unchar _inline_ea[128];
> +				};
> +				unchar _inline_all[256];
> +			};
>   		} link;
>   	} u;
>   #ifdef CONFIG_QUOTA
> @@ -96,6 +103,7 @@ struct jfs_inode_info {
>   #define i_dtroot u.dir._dtroot
>   #define i_inline u.link._inline
>   #define i_inline_ea u.link._inline_ea
> +#define i_inline_all u.link._inline_all
>   
>   #define IREAD_LOCK(ip, subclass) \
>   	down_read_nested(&JFS_IP(ip)->rdwrlock, subclass)
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 1f0ffabbde56..9030aeaf0f88 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -939,7 +939,8 @@ static int __init init_jfs_fs(void)
>   	jfs_inode_cachep =
>   	    kmem_cache_create_usercopy("jfs_ip", sizeof(struct jfs_inode_info),
>   			0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
> -			offsetof(struct jfs_inode_info, i_inline), IDATASIZE,
> +			offsetof(struct jfs_inode_info, i_inline_all),
> +			sizeof_field(struct jfs_inode_info, i_inline_all),
>   			init_once);
>   	if (jfs_inode_cachep == NULL)
>   		return -ENOMEM;
> 

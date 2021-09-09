Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16966C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 22:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5A860F4A
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 22:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbhIIW2I (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:28:08 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:43711
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344005AbhIIW15 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Sep 2021 18:27:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOqZO2MSy4TwRYL/6zg7TysiLB0yk8n5EeV65OZ/VQn2jt5SaWgBrIIHW4dw9olo9MSfa2zFXb2coD1/9K3TVoOdFgR1Dm0Fu9Y1JqC893wQ0ZhlD2HfV3eEaOvsla0Cg1GlP8478IWJKNNv20ccGx5Epjqhd7+ywm5ku94LT2NGcHoWxCMijUwTzIBblcoi/Z3DAFnoTX/4dVUKs1sNrag4wzQR4uwmSF0zCX+j2royZqvnN5vvQY7RCUoOTIDKhainzY/GAdvuuOdUY5UKzr7+rWmCdynET86rM6KWkPxXdvYX853tsdIkRxXeYwzs9er+a+tDsuid9C0WC+F8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fvfpqeXEFi0Zas0a6uwd6U8NDoY2LcgvIlxU+4C7j2A=;
 b=BhaSUMfLD8zp+qS/IEb+ujRuG1/5Pzm6YU4wE74LeUMqLeI81CDBqiQD3M4Nxu6HazoEAKIgVqKUBOpD/NWqpzrA4sLb8Di8ZlhGdXaNOuq5kkhW+KIxprnTQmMg4ouvScZ6Yi24F+vvsjhzl0y3VQAqiXlNzgCOsKpgoZJfClxuS9f6KIU1bR2OC3mj23OaZUs7V2z1ISQicRN83+I42r+7LoO1dBVuq2UFwIMDXulLg53HlFuwwObfiSKYEWYkNtC9oBsHagVdLVwpPKcP4uG6JDOSzOD+mu7tTkWPc1TthzMcUsa5xQwKMdz9E2U/LlCdNffEriQDRf5bY3VOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvfpqeXEFi0Zas0a6uwd6U8NDoY2LcgvIlxU+4C7j2A=;
 b=oDX/3iHkPh/GsHeAG6gW7hKznIsrE3vukmlsbbwZ4lT8QKQ6rWaI4g1OkaDYzZPVWpQf712x5G619wuQT6TA8dpsp2oTKGTGS4LxUwxLL1M+JtDU8AjrWxZG6jgkXFado6o4fxnOzhRGmeZrTwS7Fj0omA36vebAIXhA1GDOrNViV0XlsPCuqpcvKciSnkJGdAe+7O/lzPWsMCMM0s5ENjhmxfzxuNvkFAzDzP4542Q0b8Fm9HsXxL4toeZxqwaAEqXV/jToSn+hwTu8Oqo0D+GtMyPlkfq7aKCzcioo06a//0/Af3OgAEjF2BBRssVE3KQv+LpiMhBbQFeMRy8HFA==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 22:26:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 22:26:45 +0000
Message-ID: <5cdc5c42-e218-7be5-a2e9-2c412bb8a840@nvidia.com>
Date:   Thu, 9 Sep 2021 15:26:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210909161409.2250920-1-keescook@chromium.org>
 <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.91.202] (216.228.112.21) by BYAPR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:74::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Thu, 9 Sep 2021 22:26:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24d5d93a-5099-4ef2-865c-08d973e0e825
X-MS-TrafficTypeDiagnostic: BY5PR12MB4967:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4967AA5C9365B9161E16582FA8D59@BY5PR12MB4967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw3LLq6sw86FYnqYGP5bovcVi2tp46EnBVvcAK8+2FStWzP5BhpRc/EifYMdnlzBc8lT4s/X7WJGj6+Nwb61xOSiueNWMSnP5gY1DC/OwqMqBdOWtQN3K9vu9hCw8f23G8izo2urbeystFXf3BrM7gcahptsTr7lfBgUQ52Tfb6EvhV/+g3zCdZRt5FoVZNVzgXRqh/ijUFTfTiM0Mf7scYrVhKseLh5QeFMvbdhfPb49j2awYY6WOTEyABmgNO1r97rSUsUBRjTdP2sRcNX4LguI+Lyy9mqtiBXO4ZT8NT8gIEB9sdMV3fnoTo7XZWlNdn+lPb5tdqJPNLl779iG7gST6KKmUbje68qLdxeRzwBZZkcPXlDvE4Df26Q6t64jYenW7tyncpukL8yvq0qyv3Hyt8mKlRKWk4JOsa9pcxE5V4tauMA85VE4juyY6C8V0V9Ku1GuIHG3gAN4XabuSkVycdZxppBJwdlwZk1DJqqMn0PQUlDDUjCLcyhZAvU49dWVQnwvbsB+cg/aRMD15uAhC8Q1PIEckxYsadseuMCOm1nxLC/rFdmGmyHQR0EhIRDznJWQZ3yrdPgOaWEkCcDf9fMGX66qvPk/DCTFW+qz0Yo93mS6pE9lRzEvFFyaF8Px/KdjvPS+naUde3+XtNrujLYVnpQdxH38rKaLO/BQcKSvI42lvGDx8xup8FayjN0m3cJl6ISE8F9xykgybv088RH6neRc3yHK2sSMY4btBiskH2rN2kNkoJXHebL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(38100700002)(31686004)(86362001)(31696002)(186003)(26005)(5660300002)(4326008)(36756003)(8676002)(8936002)(478600001)(956004)(2616005)(7416002)(53546011)(66946007)(2906002)(6486002)(83380400001)(54906003)(110136005)(316002)(16576012)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmF2b3RzYVVtY3JRUFpyWEFwdG5BVlRnMXc3Z3F3NHdpNjdDbmI2SkRwRUtN?=
 =?utf-8?B?emt1MEdnQ0RaSTg1LzIrRVFFNkJIVW9VQUhpMjhuYThkTjZVOU5NVmFhRlR0?=
 =?utf-8?B?VVhPUFZvc3YxSlZLekR3aWFRdk1LaFoxaFpIeTFpZWkzRDcyZndKWWVRVmhv?=
 =?utf-8?B?MDlQRUtFaVR5SS8wQVZremVtdHFjOVAvTllBVHhKOThwVjh2TldqeCtWMUQ4?=
 =?utf-8?B?Yk1YUjkzVS9tVEFYdjR6Y1NzaUN1RS9PVVJMaGhNbVJTSEFOWmlDQ051bnRk?=
 =?utf-8?B?Q3pwY3lBbmV1RklSVDBFdjFpTHJUVEpqRm45cEpHazJUdE9WVjhiNUpaSmxO?=
 =?utf-8?B?bW1WZzcrdkNqeCsxUW9EVE9TdXRzNXdtdzRldHJHa09MZDZRbW9hYWlYRWVn?=
 =?utf-8?B?VGVvNWhteDNZaEk3Ti81VUdRTjlsUTVsdFZVZzVVM1ZCR3lZY0E2OGNhbk1h?=
 =?utf-8?B?aEh2YzZERzdyR1RIZ1lHUHV0REhYdXhvN2h1T2NxWTBPbHUwYUdtVUNib3Nh?=
 =?utf-8?B?ejlEQUZ4dTllRkc5QTlTemkzb1VUQnR0SXVDTzU2aEFlQUoreDRucUZNaXNs?=
 =?utf-8?B?cUlaazNINW5uV2FYL3h5MmRnVHVYTE90d0VZY1hTZjdHaWlpcGNqNkh2MUhB?=
 =?utf-8?B?UlQxakwyR3ZrSmZ3d0VnTHI1MXhYd3dYOHBGajhHQkFiaW5NY1VaVVBEYndG?=
 =?utf-8?B?dmEyU0V2ZnZWOWU5M0tXZHA0b0hiRmV3a1I3Z3ZxY0U4T3dBVERoTmhtTDAy?=
 =?utf-8?B?YkY1NS9UMjhEdmNVOGF5Nmg4TU5PVmFIeUpLUS9rZ0EvUVhLZDFrY3FyWjFL?=
 =?utf-8?B?WHA2NzRWQmV5MEJpTk9DVy82L2VnR1M1RzJXc2N6Tll6dlBrQlhDUUFPVjA0?=
 =?utf-8?B?S29NWHh3ejZ1bHlzSFZDUnR1d3NlQXluelNHaU91SmJKWk9QRlJDSmZ1WmlF?=
 =?utf-8?B?amxwT3pRUWszV2JLNmQyaUE0SUEvcWFFb0x3clI5a3BId2R5emUvS2krakxt?=
 =?utf-8?B?QkZDNHhqbm1hTktuOWFLeVcvK0Izd28zNnA3MDR2eHB6YXAwRmEyT0Z6YmJt?=
 =?utf-8?B?M0xkajNYbjJQSTB0Q1A3NExQcVhJQk9qOEpEV21Sa0hyY1JqQ0xibUtVY3lR?=
 =?utf-8?B?NG1LMk40Z2ljRFE1dGFvU3JZaGptRnlVNnE5OTVPaDh6cnVTM3l5d2hFVkVn?=
 =?utf-8?B?NVB4SzFjbVVLL2M2MGZTdENLN2xpZU5QMnRITkEzTUhKbjdUN1IvNStEaFdW?=
 =?utf-8?B?d2VRNEhldmlQVFBuYlBSQUV4UzN1QTQzaXVaYVFVUk1zV2EwMmx6UGxQeE0x?=
 =?utf-8?B?S2N0REE4b2Zub2NqWE9TQ0xNTmwwdFZaR1dpYVFpTTlqSFRQUmNKZkNoczNC?=
 =?utf-8?B?OUxHcmc3ak5kNTJ3azdHNWZ3RXBFK0x1VmRBcGRrSHBIbE05TWZlSWtZUFdz?=
 =?utf-8?B?a1ZENVdvRVkySC8xcVBnSE56YlNHRnZhNFE2SzZXd29BcTdUenExR1B6WUtG?=
 =?utf-8?B?YkUxVC9MdFZIdmUxVG9WdUlMSXdRRGFIaW1XaXU0R2Jjc3pnU1FROTVLVVhs?=
 =?utf-8?B?dXM4V3c1cG04MzBCTk9zWkdoUmkraDFVRDJUVTNiNFJhZnhZNE1DeU4rWUZ4?=
 =?utf-8?B?OHkxMnZBd3oveG54c1B5M1J2bVVJZEtXVjd6eG5GaHpJUllLMTkyWXYwUmRq?=
 =?utf-8?B?cHYxVGxUbDd6SWpTRndNdE42eVFBMDJVb1E5YzFVM1JCVCtRY0w4OG1LR3Jx?=
 =?utf-8?Q?V7kkfJwIEGB/GRHQbxGRdAlGn8s84tWc76KAgi9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d5d93a-5099-4ef2-865c-08d973e0e825
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 22:26:45.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L3KYQHA6XIfePbSWZSKF15PSWrCZNkaOrXtNApwvj2yH4B7W7Cz+5fvATRbFe1Ijx/8txcE+YMXQoWKGE74vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 9/9/21 13:27, Andrew Morton wrote:
...
>>     include/linux/thread_info.h:213:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
>>       213 |    __bad_copy_to();
>>           |    ^~~~~~~~~~~~~~~
>>
>> But the allocation size and the copy size are identical:
>>
>> 	transfer = vmalloc(array_size(sizeof(*transfer), transaction.count));
>> 	if (!transfer)
>> 		return -ENOMEM;
>>
>> 	if (unlikely(copy_from_user(transfer,
>> 				    (void __user *)(uintptr_t)transaction.block,
>> 				    array_size(sizeof(*transfer), transaction.count)))) {
> 
> That's an "error", not a warning.  Or is this thanks to the new -Werror?
> 
> Either way, I'm inclined to cc:stable on this, because use of gcc-9 on
> older kernels will be a common thing down the ages.
> 
> If it's really an "error" on non-Werror kernels then definitely cc:stable.
> 

It looks like a hard error, not a warning upgraded by -Werror: I did a local
repro, then ran with V=1, removed all -Werror parts of the gcc invocation,
ran again, and still reproduced the error.

I also verified that the patch causes the error to go away.

Also, I can't find anything wrong with the diffs, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

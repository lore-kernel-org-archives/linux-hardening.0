Return-Path: <SRS0=lGhV=DQ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27028C433E7
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Oct 2020 07:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAAB22260
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Oct 2020 07:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zKNpE8wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgJIHHm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Oct 2020 03:07:42 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:63049
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgJIHHm (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Oct 2020 03:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSoQjE8jcWXyE9LU3qewpe2fLxAyQIzUkOuyMmkuDNHFb+1AggmGOAUBm00L/bMiHhLUXB7XbJeVGAOJa2KU0mD+/+yWskglHAhK8tW/f6Oj2bMDQ0lF8WXJDzi/NZdrPyqTY47Yi8RjMtcI9Z8rxvoYMI0xcJcW4X+EbnUWmYfdO7r/QOuCqBjX72mhVgAZ/GuuqfTD+xQTePdaXd7x+hWc6i1cIupiE3k0DmySTcUn5YDFDw3DHfdqbXi3LJSUkxuIcsCgOAiCPjGHwe7w2TSx8JIU79PkiEN8ZRh9qggf7eewi8HHMchUsrg9gVVKU3P2thXX8a+OE0bWQ/n72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtSzWU8QqFxbw0Q+DmOQb0yEWY7U8XgzCyDFJ7Dgi3k=;
 b=Vo6rmXl773xStE0kV5TnaTltWs06vHd2iepBrNMiH84nU7ns67v+y+BKs2HKeIOD57otKOE1d5bQ3MJfMSoNkv1trTPqjuorFTOzsdF4vvLZayjU7YGocxW6B90tdbWh1ZO3abWhcnjCoUpbWvy3vKgJuC5VCD1LOp4YMu3+gbo445NH03Ryy3JrMTTt16B//ubFsvw6hA0l2s/spDdQqs/2ogy8yYsIpp0mwUoVQVOSxzcphljuP1QzOfitpPz4CCQWM/IxDwNr5affqHJd1FPpT6XD5T7n2RZEUn1BNrveHGAs1evSG5jOawTzDTcl6ox88h0wFR3JH439LY4F7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtSzWU8QqFxbw0Q+DmOQb0yEWY7U8XgzCyDFJ7Dgi3k=;
 b=zKNpE8wzC1amxULrLFcXgd1a60i1M251joYCmTXtx0MOaVxXrtw0MvStJviVT9EYJXwiAAKJhSsnBAZdFZirMbMOfaTUQu5ms2DLwmHuglDjUMYwAmFtjId7WZxOLfEh4u2cX3hQ/5ArpQPzOArXc7Gr2Pcu34dW3nEj7qeyOyQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 07:07:39 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 07:07:38 +0000
Subject: Re: [PATCH][next] drm/amdgpu: Use struct_size() helper in kmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20201008142305.GA21249@embeddedor>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <273fb8b5-61cc-d65e-bf4a-43767eaad348@amd.com>
Date:   Fri, 9 Oct 2020 09:07:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201008142305.GA21249@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:205:1::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR07CA0015.eurprd07.prod.outlook.com (2603:10a6:205:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Fri, 9 Oct 2020 07:07:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c9c02f5-5fb7-47d7-027b-08d86c220147
X-MS-TrafficTypeDiagnostic: MN2PR12MB4343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43431C36D72BCA911B5DB0DF83080@MN2PR12MB4343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnUt1hMFnxnB8dqwHdnqWCr8N5fPoq2gCVuRBE8gbO1Zr0c9JOGZliqdFa5u2rmQgr966GbhGlkjJ3+rCDAcouj+NSai0ORsNoqwlatTYj4aTMeFPmrxD3SLr/qM2BXj/3Gr+zv6lkcbtWE+QFHLcahi9Q6hdfvidGo2hsXmJhZ1d7JK4FdQed2uSKs3wBxy4EWNb4Dm6hWBDVqqBQLDSByXsMTylGf0HDX5XepXd3Tqc2wgO94oSQTpsiwyfSY8X1qCPgYL0uE9/V3+t7DNCMxo47pz47X4P7aO4x0lvAHR/ht6SkTXBiWXdlDz1o/nA0fa2qkjlMdpgmWhuuEeVcwofj86Axh3nfMwq+CskNdgV4mU5SzMMpY4nsgn7XNR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(31696002)(31686004)(6486002)(66476007)(66946007)(86362001)(66556008)(478600001)(186003)(8936002)(16526019)(316002)(4326008)(2906002)(5660300002)(6666004)(4744005)(83380400001)(52116002)(110136005)(2616005)(8676002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W4BG0qQ+aDL3aoXXT4+54HBCupW4rXEG/8Pcl/1nsZp7Xn3WG5+s/3eYeWlwzR8LIsDDxgvgZKtcqUFRlSRLJe66OQHn8rRCXgkFYdt4xzHoUt0uKBYLcaxgdEa5aVHALfTtJO4xKtRer28vMXt1UrAx4iVHz+pk+yCYfCvKze2f0ISt+GZxpXBdfiypmo0QMFv0PMHkiBvwL4U0cGA//DASHJ4bWsBKEIYNuPPCOxWsNju1EXtOtobe8Rs5BoohqfiD5GeqpmOWKrFF6a+xOWfj694O+6GAXEoCAB/Xf8ipGlxPtZFWfOrJI84ZUCjoMGgUX4gOUIxvSo1kpXtrhSxEbamlbiXWPxjsUz4kxJrba1MSK4J2BMrbWE1HeedfDyqqIyVgDUGmkFjwHKEpxbuKtMZKdWtYPHXcqaoIH+VymUjueNqu8sLLKiROQ/+u6yE9MTbRUUdpLpXlw93WqSDAirSZM/ByT29hp1Gyz59MPI0kfT8HbHGSGTZ14E2+vSf0dYpvIdGI7j40exRGxlktcrQrg2MahTeyBsSK1sFIS//P32Nwggt1QBrp4dB4RvJi766hGJz+p9eZ/YMEJ7e/MxPEONGkk85kgWD5FQy883B4yg9vJXz9hkNcI1nJok83D66M5cfU3Jc8iNhdD0B+vbewanuVlPupRdC0yeX9//S7SSsn0XN0Svd0MFVr94f7KTVe5uxBcTClqMj9tw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9c02f5-5fb7-47d7-027b-08d86c220147
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 07:07:38.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSI+iJ8F9QSv8pwLRrfVquVf2+Souzfp/vthJpqfWGtry+ZdQ+KoH2oH3tChJjr4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Am 08.10.20 um 16:23 schrieb Gustavo A. R. Silva:
> Make use of the new struct_size() helper instead of the offsetof() idiom.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5da487b64a66..30192dce7775 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -239,8 +239,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>   	if (!old)
>   		return 0;
>   
> -	new = kmalloc(offsetof(typeof(*new), shared[old->shared_max]),
> -		      GFP_KERNEL);
> +	new = kmalloc(struct_size(new, shared, old->shared_max), GFP_KERNEL);
>   	if (!new)
>   		return -ENOMEM;
>   


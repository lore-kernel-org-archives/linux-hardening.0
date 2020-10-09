Return-Path: <SRS0=lGhV=DQ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C865C433E7
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Oct 2020 14:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429BF222BA
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Oct 2020 14:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="euOFN+Yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbgJIOaE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Oct 2020 10:30:04 -0400
Received: from mail-eopbgr690065.outbound.protection.outlook.com ([40.107.69.65]:35747
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728934AbgJIOaE (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Oct 2020 10:30:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV84I/lm/EdmwwsdT6QwaaQHeuf9Fmk8OAWlxSyoXG0r1CiF+3yH/f1FuhEORAadc7/1Z3I4zbLBXp2Gf/jT+FgtiNr7mvjZpwUVeq4QzCszaO8SeHAZz8kA4ckTckVcThhoU3vnxkWEV8EYSPp8CCbT3etOM5K3a/o/DwV+BCwRyoAAwR8E+cIVgMu4JRtOvqoIeUV3yK3giN4DynzRCyG39vXYQNhDGDOSEjdyKmO42zVkwJaR+JoNHPZhfBFhRaWTav+8bG+6cnrFANkC1asbKUu8oNDhBGzZ1a6TsGO7/+wtVQEpT4CLM697Wq1hpQ2UATnvg1OeijEQF2ppsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8HRRhEx3lleKRTEQD7f8UhAoDHN+IiT4sBWXQMPlGM=;
 b=MCgijlAsEYUa6A5hIAfok6CL6AZJLEg//vKuZXG4xQIMUxvaJF/CJLEhQfa5Gxq5BU3j9ZzmwQa3rEJMMoQ8seZ+Iy3lTA3jZb1tCSECBkvv2ByGTm+nMnQ3uqgrC75Hi+2hVxCXWE0PxP802jwDj0deD04i+fUHwx+cQnA3Rex41/RHgXetxsc1rkMtEhd7YfK8wodyjhaJeqENzXfWUPOm26LC2jeWk//KOJlfEF7vhu20VlSOsM2ftNuVxqRgs1UQpQI/IY7U2jgfzxHuUvF/s4iolOOXKRicnc7W5mqu9oT0azMGWU9BjPcmV/eobtHPfrh4FBHOKpfr9Xsi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8HRRhEx3lleKRTEQD7f8UhAoDHN+IiT4sBWXQMPlGM=;
 b=euOFN+Ypx5mKk3D2en6DeHvOLB3aZt3uJCO/bdCXOY3qsFIpsrYCDTkmEZhi+pxLULrObtlEXnk7tYkUpy+KcFlJCmQ5yOywbJWwbyV6C6p4umDZAy8gxYNtyylL48mBeg36c2DWqTWJiTv80O4/PZyz/fbuBKy9JTqv0aLxGXM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Fri, 9 Oct
 2020 14:30:00 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 14:30:00 +0000
Subject: Re: [PATCH][next] amd/amdgpu_ctx: Use struct_size() helper and
 kmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20201008143450.GA23077@embeddedor>
 <4fe00048-2612-39f3-29bb-c9424000f836@amd.com>
 <20201009135430.GA31347@embeddedor>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <de2282e7-7eb9-db79-1082-36d6508b05dd@amd.com>
Date:   Fri, 9 Oct 2020 16:29:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201009135430.GA31347@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0107.eurprd02.prod.outlook.com
 (2603:10a6:208:154::48) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR02CA0107.eurprd02.prod.outlook.com (2603:10a6:208:154::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 14:29:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1a5b6da-c9da-42d2-e554-08d86c5fcd69
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4302FC63E3E9A37971E2480383080@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CfiYDTmO1yMEFkGBPScVI18ylx6DHUNgRu5CsUBQkJ4wD83UydSAt5gdK98xP0aHliLzoFe+4ULjKY0cBqSPkOb4wC9GmEjz8H4cwBiUzdUgsgpbf1iJ5qHFe501XDgD5c8tmv1a7kcoMSyzttiejNa2Vvjxlf4gCd05aRYQE+8iASctXTsCn28kuKgNRTD8aAwI5j1t7yg/k4YW4xeu07tYb9fr7Ewf+ZhjjddUBilVZhM7u9FBAuV2MXpEswZlnYtbomU0B3CLUf0Xui17KYW3BpsnkzEm6w6DLoNA+Khw20xw5IYQYCALZljXbCb6gpjyXAVUn5jpNZUMw2AN5jY13Gmsy4X6drIuVXdG/1pMiLp8iA5KtSyiFX5Lwnu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(31686004)(8936002)(2906002)(6666004)(83380400001)(6486002)(31696002)(54906003)(4326008)(66574015)(52116002)(2616005)(316002)(6916009)(5660300002)(8676002)(86362001)(186003)(16526019)(478600001)(66946007)(36756003)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qyYR4unOw0SaE857F0W1DB2JBCPb1a992B5g2KJ6eOghue3lO6USOeDT7wU6CAot2pukB/OE3cL0Qxjw/sSpGRv4tIs2i0gziIQKNirbxj0zLD8+725oJygRb27SRdOg3u13sSJeH8PMy73QW9J9J7RTPz1HVrCZUftdOg6iSim/lPqdCu1yj+6qZllngQSQ7wo8jOgFolDi7D+1yqtJgf64p6h1kk+i1YYKS6rLKGOqkjmDxu0LzUxuJweKgFqb1ng1ZIUyGlf6/TA3A24/xnzLhLsCggjWxDEQsKLwwUwXjpqRwEbm2nXgzdA7s7/E5EtllS4PvxjRLAFw5/NfuqKCpltghIgnvCPOK7uTN89Xi/IXOLwDd4SIRQAOSnZBwu4XAJYfbjcq8Du4iVyKjnIJx4wT79uEwNgzZSV7Hmb+D69VxPD2Vds5huLAtW41ki8WR4CtxqL8EXhVLf2+IvZ0XtbRYa40miZGNUvEAvdyjt6Hqxi7mcgJY9KuXDWTvI5zr/Sv8fHZcrIKc80+9lMwyYMDBQKiWivNpsRdqN7F234ZAWywfFgy8arn1fJ216JTs2IRFx1Fm3oWzBPLR+Q+XcFihNhPh8m6gXzRUGNmvLw0I94f7lOwbxEbKFcgkcKI+IlhUpqv+CIZZbFz6gX/KgM6hlQTYisfU1KSRM1Azgs+/paiVeFOEii54rbD2OMloWPcLy1j4UIpZ15BwQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a5b6da-c9da-42d2-e554-08d86c5fcd69
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 14:29:59.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91tCQdavCY71BwONN0CY21PzO4dTT8+jp85NtsEEPhz82EQUELmAYo1rCWxmsaKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Am 09.10.20 um 15:54 schrieb Gustavo A. R. Silva:
> On Fri, Oct 09, 2020 at 09:08:51AM +0200, Christian König wrote:
>> Am 08.10.20 um 16:34 schrieb Gustavo A. R. Silva:
>>> Make use of the new struct_size() helper instead of the offsetof() idiom.
>>> Also, use kmalloc() instead of kcalloc().
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index c80d8339f58c..5be125f3b92a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -100,7 +100,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>>    	enum drm_sched_priority priority;
>>>    	int r;
>>> -	entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
>>> +	entity = kmalloc(struct_size(entity, fences, amdgpu_sched_jobs),
>> NAK. You could use kzalloc() here, but kmalloc won't zero initialize the
>> memory which could result in unforeseen consequences.
> Oh I see.. I certainly didn't take that into account.
>
> I'll fix that up and respin.

Shit happens, we already have a fix for this. Alex merged it and it 
immediately broke our testing systems.

So one of our engineers came up with a fix which should already have 
been applied.

Christian.

>
> Thanks
> --
> Gustavo


Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20BAC433E7
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 07:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9183520739
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 07:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Eqihwonz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgJHHT6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 03:19:58 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:47713
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbgJHHT6 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 03:19:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1Jx1zvm2YKQjSVexW/HiHytVbeO2x2Rfu3woHwpmzFuKn7H7tB7MN7xOGaPeohnS164d1fXFmFy6tUJNYwMMBY9roWrEmZJL1mnHGP/yZ+l3gVoSrfSYHJLjC//WzkAQ13ahcI1LgRZOgNNyhWjb0VMOXh538KqErrvFm6zsAw+FpPGfawBnpaHsmDLQimwPLxASSKoFwerzqfgVcDQia2z2sGQ2pp/1VloTIzhETU82UAzJ+jn7vtQwsqpaFGGxbYIv4lmrEewy11vdIZ4aLWTBgA+KLi6bysHdK2etwlX4iWI2bHo+5fCGSYhlw1L6n8XxhYCmkbcyjNSGXF7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiJnOc7U2DDt0XClKewfzOUcZiZTxClt7hx9pyXrrIc=;
 b=BffbMqQsJ5htd9JAqlbRbdNPmEVzR5j8ZoxeIjaisFfDWUBN1/kAtYB4wJghQCyN/XCKNIzHtlxXWzLY051pXt3O4a/mQq7S+HLvpGbub06x6uzFTzJDhPXcXizQCOyrHTrL/sfuz/ZrXdxivfNq3iF4a/wt3ClN4GwYPBm3BcA56ZgyYzUbT5FIuHCixaxw7Gm3eb79UgZC+IBnPCtYxOsYuMT0soK53C7dJ1jB+EHq7A1Sy7mxoNQkTKYYLQVl28E547JjcwC5VW3VZDICs9zQFxy4MsySfU30kfwQOWOAL5CoGNmPygXoFUw97qckOv5H+BQWBjL3hRUvktQfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiJnOc7U2DDt0XClKewfzOUcZiZTxClt7hx9pyXrrIc=;
 b=EqihwonztYuhx+E7/F+W7Un/jBcRel2G32b/dPXF2xjjAlBBxn0waS7Eo4/F5l0Pv/6yiJ4Kf9K+7CWNDVaECf+1WDNcyLWy5YbSJ1zKrZ7YxF2Na/sp5FWg8Pek4S/AZmAotPCAn/rW9VE1g/eZ0ZsjeDW4SfkxOGnWkt342J0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4797.namprd12.prod.outlook.com (2603:10b6:208:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 8 Oct
 2020 07:19:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 07:19:53 +0000
Subject: Re: [PATCH 00/14] drm/amd/pm: Replace one-element arrays with
 flexible-array members
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <cover.1602020074.git.gustavoars@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d71c8436-334c-45d9-d464-9798e75f2a73@amd.com>
Date:   Thu, 8 Oct 2020 09:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <cover.1602020074.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.16 via Frontend Transport; Thu, 8 Oct 2020 07:19:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db6e6251-c302-4fb9-34e5-08d86b5a8cf1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4797:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB47975CB08BD9D68001CBA4E1830B0@MN2PR12MB4797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNM74Yel2zbAGb9+kvk5F+UBC6ie3neX7/rg+JBDl9c4G8BoK1ypBDGWCcJERY+5gadTQ8gtAPRP6W5vFH6b7dvB4ZcFPA+tS9F0hojRCJZQQ7rj5ut08Il0mDTjom/BUWxpK/l+dJOAMR+MrI1kELK6x3Vsxr+NH9qvUl/PFw9f1advQDX27nDVMIAv6VpuU3+eQbKdyn2enCZnkSr4HVVuqcb0RKyZVbcb0jrssN9aCB0000zA0GzNCKrrkkSYhaBeTMKh3v8tqIda0F7V8wGIywLkb6x29ymof0lUAxI8KItM3YJfmSwH2VJMFYLCARShMmM8EgQ+EgVBjUa+gqoq1/JS486OvpD6z1QCqkAkD47rm0qMw7zK/LzGHygK3NzRHCEfugQqZ3FGikVyP4wGy6550ABqSXkBEoGGAH4xnXFw5BJ5h2qeuVxTGc7tTqwe1yoQmrksL/yvmZ+xvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(31686004)(36756003)(2906002)(83380400001)(66574015)(8936002)(966005)(52116002)(31696002)(4326008)(83080400001)(6486002)(66556008)(66946007)(66476007)(8676002)(5660300002)(86362001)(478600001)(19627235002)(2616005)(186003)(16526019)(54906003)(316002)(6666004)(45080400002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CfuIukV0m143oELk3fMjmF9/G3lUH8k6XIWn1WA+BNQnopsjKtTtyAg1zDtZjPBTxZ6kPPr20xhM2ycBEspYjy6DrNxM7glGYNdLC+PuqUXqPMBRpqYc+MW+Cie5CxU/9Uf4V5Ya9c2fcKlgfDyCulyNAwmGQg9LN6aVoBT4g/Z8MXdMn5w3sqyl9mKPzxpD3kCmiinWJbcIQ9/rwjS15k0mtBt0hsT8MFMBky9hejbYb8sDPFLSSejWYuYJysk8+EZii7TwUwlxWYRiS731Lx1HCMiu5p7GDufPLLibMfNdA18qcyY7UpFOndi2QG4EPvg2d3l8bwoR1RxBc6njgEqiz1t7ncR3sR80tdXBqiWO4DQMZVMS4mkHeIUh7Ht5kBSuTzTUIh3r3g5JzCrnlo4w/vlWBFO8niqOmBKBxR9GtGDF8/FaEn4WypIoDgXxRQjeuIQAKRZ2aY51VFbJ9q7fSg21gjcIW9z4JHXaPQmHZnw8sj09fSmZuapj+yIKkePwuJuroG//Dao5z/ayBlhVkKG8zjhPNZNIUtdpSapbQMj0Tu4khmPQBAVerSwkggwkPnkRMei72v3Np+oRV20SwbTucYr3swtMSN2uiGZpdQYY85I7ufHNlScUseMvcm1h1MdqAmaA0heArf7KDZQbRwOk5RuC/A2MGQ9cCAn3Qf/FwbE2ILywh64AsCS8PvQwqgbtiB3SFw8R0S7MQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6e6251-c302-4fb9-34e5-08d86b5a8cf1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 07:19:53.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vv8tKeS6aidKr/Dd/qRAdOITgroC5DsT9lJRjd+o8NKb0O+sv3kgxAKtNwgwXcxO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4797
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Am 07.10.20 um 18:01 schrieb Gustavo A. R. Silva:
> Hi all,
>
> This series aims to replace one-element arrays with flexible-array
> members.
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use “flexible array members”[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> Refactor the code according to the use of flexible-array members, instead
> of one-element arrays, and use the struct_size() helper to calculate the
> size for the dynamic memory allocation.
>
> Also, save some heap space in the process. More on this on each individual
> patch.

Ah! Nice to see that finally be documented and cleaned up.

Feel free to add an Acked-by: Christian König <christian.koenig@amd.com>

I also know about a case where we don't use struct_size in the DMA-buf code.

I'm the maintainer of that stuff as well, so be prepared to get patches 
thrown at you to clean that up as well.

Thanks,
Christian.

>
> This series also addresses multiple of the following sorts of warnings:
>
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu8_hwmgr.c:1515:37:
> warning: array subscript 1 is above array bounds of ‘const struct
> phm_clock_voltage_dependency_record[1]’ [-Warray-bounds]
>
> which, in this case, they are false positives, but nervertheless should be
> fixed in order to enable -Warray-bounds[3][4].
>
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFlexible_array_member&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=5LEWyR8pYSxmHsqhHiYiOS%2BPPk%2Fm5suOc6H7f5cIBL4%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv5.9-rc1%2Fprocess%2Fdeprecated.html%23zero-length-and-one-element-arrays&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=wOqxnNkA9FnOI%2BfB3dHn9RU7cqPJ62qqGCK9gsd2i%2Bo%3D&amp;reserved=0
> [3] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Flinus%2F44720996e2d79e47d508b0abe99b931a726a3197&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=x%2BSJeOrQA11HXoTaZEdyLyNWL9rC4GngDyoDMRBUn4M%3D&amp;reserved=0
> [4] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FKSPP%2Flinux%2Fissues%2F109&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=48155uVo7AboCdSZfsTP10i2rHfBJctG%2F432lD%2BpfHo%3D&amp;reserved=0
>
> Gustavo A. R. Silva (14):
>    drm/amd/pm: Replace one-element array with flexible-array member
>    drm/amd/pm: Replace one-element array with flexible-array member in
>      struct vi_dpm_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_clock_array
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_uvd_clock_voltage_dependency_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_acp_clock_voltage_dependency_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_phase_shedding_limits_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_vce_clock_voltage_dependency_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_cac_leakage_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_samu_clock_voltage_dependency_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_ppt_v1_clock_voltage_dependency_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_ppt_v1_mm_clock_voltage_dependency_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_ppt_v1_voltage_lookup_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      phm_ppt_v1_pcie_table
>    drm/amd/pm: Replace one-element array with flexible-array in struct
>      ATOM_Vega10_GFXCLK_Dependency_Table
>
>   drivers/gpu/drm/amd/pm/inc/hwmgr.h            | 20 ++---
>   .../drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h    |  8 +-
>   .../powerplay/hwmgr/process_pptables_v1_0.c   | 85 +++++++-----------
>   .../amd/pm/powerplay/hwmgr/processpptables.c  | 85 +++++++-----------
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  2 +-
>   .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   |  5 +-
>   .../amd/pm/powerplay/hwmgr/vega10_pptable.h   |  2 +-
>   .../powerplay/hwmgr/vega10_processpptables.c  | 88 ++++++-------------
>   8 files changed, 107 insertions(+), 188 deletions(-)
>


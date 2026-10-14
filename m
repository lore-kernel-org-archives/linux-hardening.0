Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472C40D588
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 04:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951895; cv=none; b=tw8RIqYxwyQjjP3xQy+9ZXigDH/2HW8bnGf97DmC/wxba8tqocgY6JYZS3cOT7X/GMNScKX53fymy02mLnZ66CrXJ6BZAnVQYpBZLwqPoG4JBCTQkDVkUPsW1s4Kd9B90qQf3z1sr8ntNAGuq35aOMxkfSnLRrhXSkhZLHcyFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951895; c=relaxed/simple;
	bh=uX2IrYZKuunh5Ay8wtG5R15VefK9qebescjFxGpBE28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPgECmXZrAnVr6riWe63M0JE1Eln9Ej5ZdEmlYLbrdW/jx0EJa4EffKDZBjzVSIvakchZcvjmo54fEkd3N/G/eEL1Fpt2ZTYMY2UijH0vV3eTicsSP1QMd+ReJdf9XzOEHegqzM3jzNyBt28nFTOw4w8eImM7Kp4iCRwFLkQuMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mfBIXI1u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d/gg43Oy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mfBIXI1u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/gg43Oy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E1042N2874283
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 04:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R/YWOWusTmnn9Tx8/iLnPWjpANYDhhlrDY+RymDC9lQ=; b=mfBIXI1uLAOYHNpx
	M+pskrgQQbpJj/+60jNFLzZFxHw2r6RDPCnEYQak0C68FqNpjyua8eynX8SGcd1Y
	2J1k4+K/t/BHMHnNSVt94VWd+zjp21ADu/+gT5GHSxkze+TVoAJ8ZcEJUegyUcj3
	l02tjV+K80HtT6WpkHCz8hJA1pNAkGFI0embeDgtOOxCvfUQQ4c9lcW5zqnNjbim
	+IIDJbRdlgftjP27N4Ac7M+zpCtJs+D/UR8kPP45vYPVDrD5gR3xqxJhNmnwyIgi
	K4kI1TWbCLNx+Vt70sIiD4gGFEtC25wsPGiQD9gMthErtmViPMA3SxZL1fMU3msx
	O1ZOMA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphgnsq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 04:24:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e601800e58so65500825ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791951891; x=1792556691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/YWOWusTmnn9Tx8/iLnPWjpANYDhhlrDY+RymDC9lQ=;
        b=d/gg43OyQJIyLQJ4aba4T5jNV4ea758iHy66fF/nH8LLj2KfCNUHNREkHxifmGvqKT
         VRNCeBb60ZbgI8uheCRTIVLFGbwQAiD7wIvL+z2wsQUKxFIQZCAx+Nzoo1HZATZBG/In
         /j4zZ2PyktfeXg7ojU4cxl7+cKNp2DjVZHb9rL1jewPuV60mK4SzbrTyxwuXkID4u9GN
         JWcTTAwL5N235gL+1OIEtc1wdB4OidvcqwtT98iIuhzvwPau2URpK+GbHS8MvUXpi4eP
         +nKo8am43xlIUmON7+2+yqh1CUdDxCiBpaNsJGaAuxp4rv+PX6ShGRqcY42alT/pXmxW
         RKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951891; x=1792556691;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/YWOWusTmnn9Tx8/iLnPWjpANYDhhlrDY+RymDC9lQ=;
        b=X43BqJbVApaq738VTveunBzOb6IMj1N865UZXZT+Ow9FVe7ZRB2jaGHRR9YLxtAjMZ
         kD9qhOxWcZyrYvdWgQt209H6tVa8t6jVR64b2RVEqYwXTzxTmtJ4yeWwu9W21cA/30xt
         j70EwZneMkSBkvJ0cXIl9Lxk+0AN2c/VfFlzj5nlVSVsxnrEjusgC9m9Tjc7DR6cFZsQ
         H24hDFu5QgLS1y5iF4ksXUyMgC6IDUhlh5V4p9CtzRpIUFz2vGJ59f999qj6hMYFyzm4
         lb91rFqLcAkxutWflp6gFGbt3cRPeH1L8jg3juidlJ0XczI9tkQzSroHbrBF19iwxr58
         dzlA==
X-Forwarded-Encrypted: i=1; AKwUvBx43QXp2RY2JA3lll9QnK/5L4ePH3Q2xPvtaDDXZeUHHaK1nZjLK+cTqdRwPES0pFBedvW1PGRc+csePXxjwfM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBmVu72M4YEKPAG52Y2dFvj7qoiib6OXiOz4tJ9j/9UUVAzSkZ
	FzUO26TlklixJXSR1DMs28RtvtDh3Hq1nghcFFf7uBUDmrWO9GL79JeYPt/K0GCaVSBGDDc4DDO
	N8W4EtnLuy1cICwELlI8jPebrvs5gmzBJDB6syZkOuL1XXHiNVOtKLERjsqbf/X2hcN/KpW8=
X-Gm-Gg: AYBFou11+FilthEapij/VtxOzXDfnPmj31su8AeEEhGvsn3GHNAsf6HKUIuqa3POmu5
	qyr2S4B83S79QYl1RlGuJJp08+qtnYU8c7id2bVzZH1neLmvyvO9GsSyEZ4laEOa+mICCanwu+s
	fNFgmLVTcLOVSCd6EiSk+q4Eyb8c6UddrcunxjuRmAD4Y96cARCbtHVG1kl4wUln8vjFhdyRE0F
	mSNThU9Q/S7UtYPZbjtLSI6+uA5kN6Dv1ZTNqTmDWT96m04saTVhgckZ0i8nt45UweCZ/fx+pqo
	g1Hxmuo7i/6gRiq2hIRRg7iokHDEDQSzaGL5FvzErGBh5zuoAjusKAQuVxrpfZmFZgFFzonpQV0
	Lpa/gnKltNkBokEILq/RM5Cm/H3kRHElhaUu45D564Wxufokm3jQrXDND9jsicoIR8VKvJk1z
X-Received: by 2002:a17:90b:35cc:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3ab3a33db36mr12329603a91.8.1791951890958;
        Tue, 13 Oct 2026 21:24:50 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3ab3a33db36mr12329579a91.8.1791951890405;
        Tue, 13 Oct 2026 21:24:50 -0700 (PDT)
Received: from [10.133.33.242] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac63279277sm860530a91.1.2026.10.13.21.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 21:24:49 -0700 (PDT)
Message-ID: <252e86f2-9663-4ac7-a19e-6056b44e769b@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 12:24:38 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] cpufreq: Initialize kobj_type release callback in
 ondemand and conservative governors
To: Ian Rogers <irogers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich
 <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        David Teigland
 <teigland@redhat.com>,
        Alexander Aring <aahringo@redhat.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini
 <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        driver-core@lists.linux.dev, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        gfs2@lists.linux.dev, xen-devel@lists.xenproject.org,
        linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-5-irogers@google.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261013223946.1836757-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Hs8hS6dOkUIyZ_C2TLy__uPeMRd5J70N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfXwgtHeWvWEkDz
 iXp0nzxG/X/BQdgyxwegRyjPscPD/umKyYp78vHbLyr410mvSjGG1sy/qJhoCIliamSyNQLOWPv
 PfNYcmfvJalSNOlpoZhmJH1wmWmGmV4=
X-Proofpoint-ORIG-GUID: Hs8hS6dOkUIyZ_C2TLy__uPeMRd5J70N
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf0414 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=1XWaLZrsAAAA:8 a=Stt4M9KXtKJ5ZbChFzoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX8wcPU62DxTeU
 moTYalgIZUOksG8NUjgDScCNRlykfHvdom7ahFOM5lAmQ2vKqj2KwufZT7ERdBp/BRMkhTZ6Umb
 E3HIX6BSSbiSfWXkbdgT0UsS8dmg+dUFiEz4POFB0oKyhafrgEKzSY1xcwvQdNfovgDZ1ThpFo6
 uVNrbBz3Ij0TkDdI3svNCwQB8I2JN7Oadt1fIv+1DSiz7uH7wNSlCAHClk39uyD3p5gWXGD3ma4
 fZGqqFLzSgG/OETo3iREhZF8vXLmJTR2j+j3dYS+kjsPI0RRbW3mBmHcEQYJtBlyG09QU6GiA/O
 waW6JnEWWfPuzXBXeTvCiyzHDZ1X/3YtiMMMjLl/wOdGU9a0CuHG2vi1rdWtwNe+liNdvBDj9UM
 8lV7w0uWSlCq9cO5o5aiaibcsv4ABo93toZd5tt2X4ZcCRy/wqyB8v/XigXeS62VpAKRQLbTdBp
 kkybfjjo+hjLTD4CyPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140017

Hi Ian,

Thanks a lot for the patch.

On 10/14/2026 6:39 AM, Ian Rogers wrote:
> Export cpufreq_dbs_data_release() and set .kobj_type.release in the
> ondemand and conservative governors so their gov_attr_set kobjects have
> a valid release callback, matching cpufreq_ governor_dbs.

Commit a85ee6401a47 ("cpufreq: governor: Use kobject release() method to
free dbs_data") has already addressed the missing release callback
issue(it adds the missing cpufreq_dbs_data_release() function.), with 
its Fixes tag pointing to c4435630361d.

Besides, "matching cpufreq_ governor_dbs." seems to be a typo?

> 
> This prepares for annotating struct kobj_type::release with
> __require_explicit_initialization.

It would be better to use "cpufreq: governor:" as the subject prefix.

> 
> Fixes: c4435630361d ("cpufreq: governor: New sysfs show/store callbacks for governor tunables")

Since a85ee6401a47 ("cpufreq: governor: Use kobject release() method to
free dbs_data") has already fixed the missing release callback issue,
current cpufreq patch 4/11 seems to only move the release callback
initialization to the static initializer in preparation for 11/11. The
same callback is already set at runtime in cpufreq_dbs_governor_init(),
so there is no functional change or bug fix here. Should we drop the
Fixes tag?

So, at least for cpufreq, the issue described in the cover letter
doesn't seem to exist, right?

"Patches 2-10 fix 10 struct kobj_type definitions where dynamically
allocated kobjects, ksets, or enclosing structures were either leaked on
kobject_put() or freed prematurely before kobject release"


> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
>   drivers/cpufreq/cpufreq_governor.c     | 3 ++-
>   drivers/cpufreq/cpufreq_governor.h     | 1 +
>   drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
>   4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 0b32ae28ec85..38c3bd5bf75a 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -316,7 +316,10 @@ static void cs_limits(struct cpufreq_policy *policy)
>   
>   static struct dbs_governor cs_governor = {
>   	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> -	.kobj_type = { .default_groups = cs_groups },
> +	.kobj_type = {
> +		.release = cpufreq_dbs_data_release,
> +		.default_groups = cs_groups,
> +	},

Nit: In that case, may I know can we also remove the following runtime
assignment from cpufreq_dbs_governor_init() as below:

gov->kobj_type.release = cpufreq_dbs_data_release;


>   	.gov_dbs_update = cs_dbs_update,
>   	.alloc = cs_alloc,
>   	.free = cs_free,
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 710d93ec89b5..97b64985927d 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -404,7 +404,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
>   	gov->free(policy_dbs);
>   }
>   
> -static void cpufreq_dbs_data_release(struct kobject *kobj)
> +void cpufreq_dbs_data_release(struct kobject *kobj)
>   {
>   	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
>   	struct dbs_governor *gov = dbs_data->gov;
> @@ -412,6 +412,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
>   	gov->exit(dbs_data);
>   	kfree(dbs_data);
>   }
> +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
>   
>   int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>   {
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 73b8ed7cfaae..c03d067f42eb 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -148,6 +148,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
>   }
>   
>   /* Governor callback routines */
> +void cpufreq_dbs_data_release(struct kobject *kobj);
>   int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
>   void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
>   int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 9942dbb38dae..7386d043c665 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -374,7 +374,10 @@ static struct od_ops od_ops = {
>   
>   static struct dbs_governor od_dbs_gov = {
>   	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> -	.kobj_type = { .default_groups = od_groups },
> +	.kobj_type = {
> +		.release = cpufreq_dbs_data_release,
> +		.default_groups = od_groups,
> +	},
>   	.gov_dbs_update = od_dbs_update,
>   	.alloc = od_alloc,
>   	.free = od_free,


-- 
Thx and BRs,
Zhongqiu Han

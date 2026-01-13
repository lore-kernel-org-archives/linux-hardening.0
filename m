Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392B2FB0B3
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321751; cv=none; b=U8gpoyb2+FR1/250GoPy3FO8jWivLqAea2xSM5mPurGR+kBtgTP3Jk5GEvdATrkNB/5wQ2Ib091bIKbWavF3Z0/tIGbCp0szgLdp9nEWcrEt0CqmMbG/PmorvJ/k5nOpnkd4FOGUX9q+PWc5nV2VzcjivV/MOCxSsk9bm/tIfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321751; c=relaxed/simple;
	bh=oUPYwQN15xpKqjNWtjDqdTFQd7zC6BoxdsN91zpf55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR+Z/fFk4HYMtL7C9AjM3VK+lLKqa1m+MSr/oFNHTBT/vlY741O9HXcSSRbc48DagdgsnXEOsd5pv/6IRB+T0EGpiRMsCOsoiWEnxRWSUNF1UVHbYAMFCQtkFKYu4eXu0faFEZuVEC/R1R8GmGyQagqaydiW+GhgsrgGdWvcvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h6MtjU47; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SnwxYO17; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h6MtjU47";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SnwxYO17"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DG5CKM1294998
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 16:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cIn5H/EXHlleEAeuN1rT2GBX
	pPo6fP2DFr4Mp6yQNT0=; b=h6MtjU47w1PHnUFq0KDb/GRAfBi1JEHu2lTMIpyc
	cqAD+bc1LGy8/TG/gfUjoEiqzQmuk+kyMYsqOX6aqMyevJPuhwCkJUFBj3Rt8aVG
	+ufCmNSUcu+UF5tCQSOyhiPWfUC4Kn0Wa5H23HJdxo72W0y6hF5B8xdfnvsYdi2W
	ipinFNeNUHPEZnaabab9G93Qcw9UdAI8Zaa+c6cbmoGJRFLcfkx3Y0pp5I+Ujoe8
	GNlxjYt69KuxsvIiz2/W3J6fNXVd/LXNyHBlosiUcMffL4FX2PoPw2okX7CUh2Mq
	it8SOOvW2CCXVHDJFUqdg+DIgO4SiK2RZDGAlLEcFDFeSw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bns8v02vw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 16:29:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2e2342803so2031395685a.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768321748; x=1768926548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIn5H/EXHlleEAeuN1rT2GBXpPo6fP2DFr4Mp6yQNT0=;
        b=SnwxYO170M9LFflaroEXzk1rTMzypq+UXVKvow77N9DVUg6tTSIZ50XRPgBQwAoEoT
         Ued+nDHEL6wFiIGGwwEG4Xaq12tPtEb9+oEtpRITZgVyzeFdlxd5R3EY8D5nQf1uTR3b
         Slr6f/YfHDI41Bu5UheoDjczlGQEBhBGzvM6xQCmnFsfah9eQ8TLg9yxASW5595q3/C6
         Jlb28AY1sI+SMJMiZxgclSlJmyhdt6cIhh+8Dl2dcaH8NodMeXtKFMxr64ghCHq2kCBF
         UQ/vHjvVSryPq56oDAlh/EXmGkFpD2/ULpu3Nni1JATq+UKZ3GycKuC1AmK1nEXfbgRo
         ToAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321748; x=1768926548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIn5H/EXHlleEAeuN1rT2GBXpPo6fP2DFr4Mp6yQNT0=;
        b=bSCZnSOBwiCii9V/gq++q/tCO7iLgmg+eg9N+azUGvTQ8XxFidYZwETdQH7Qza44qa
         5VgUWUJwxl4peqsAYgEzWcEDoSrWt6w5TwtCSjq6kkN16kSoFZFBnCn0wftNmAlrnVZy
         7QwqGQh80b1RqDsegVs9iskjD4Da6s/zwht11tcYJ4sGe4njMGftdBJ5gFJA+Twgm47t
         jMZFd0NhgS9lnUPKEDt3QpCe1XMC7P2WZGxtl/UxOouX1gBkJNIB4yfX2X3NDSDxUhnE
         jMgmki4icYOi7tRSrcWJtW4HZy6WvBIc9KZIK2qRyHC5kGNZUKHVc7oqWJl5DIpii4SM
         b+gg==
X-Forwarded-Encrypted: i=1; AJvYcCUZnQrwzjT5p4JJeBHOcePHHwoCcnRARF7b9WGQnoa3ymLpIundfjVpswfEIGnZ+iXpJbN6N7nelTwEfEeg0/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp825umeW3/qHHuVfj98K51/zl+lW4Jk7dLM7/Znhr6AFAutBI
	vrbWWTY7M38jMON+G9VSdb32iRkupqoz4t2EUrjoHYbxqvff1/VD5ElVqINw+rlXGBRmS0FrzU7
	DXhXfJofJ+1VvLTB7eRsSL4+z/GP/rYtEqUE1V4BT50h+Z+PXm21QSdu70JiPiozbt5uwE2Q=
X-Gm-Gg: AY/fxX5THRy/I0nS9zdubHE3jwKSXCCZEW3w3gKEjWEFbvpuhkyalxfMMsF9xr1G8It
	M7yvvyt8vaJviiF6VxFF6QtY26BVeYb6c8lUTtiqzPqPqVPBNEv3Gd42qOragpMFFx9ku4qCl7Q
	V60cTc8on2J6wh7+UIbPNnQMyqvKbropNfSoMyApgQvKOOgKq4ejAZy6AYZxMQyOxt9pbzwPv8/
	RI3iSzle+f/stHTAoUmz7INoGx61J/a8cMYqHlnWx54K4VTPiTROIZjOz9RsJoL0xwpnoRJEGwW
	OxJdub91XNT8vnD48UkHDeqNOWK1wRylO4SHPtA7KIyYtN36/d9vvYdCPjQRgIx0rW9/ig+hRUg
	mI7v0QKPZuGSJoVdaxcP9AjV/v+cRaUrtvY2bfk/t2ERIOb/0/0Ttw6CTQzQRFK4OLNWBQ49Bg9
	7RaU52YRogEGUky1ZhC+Sh14s=
X-Received: by 2002:a05:620a:1a97:b0:8a3:8a0:a4fe with SMTP id af79cd13be357-8c3893840f2mr2997452185a.32.1768321747703;
        Tue, 13 Jan 2026 08:29:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVkPsQcxQkr+cU1eJ0h1aQeUhC2BF2dJvRQ4lN+2W+Xk0GRhFMTy0HCKzKnUPMS0T43c+GdQ==
X-Received: by 2002:a05:620a:1a97:b0:8a3:8a0:a4fe with SMTP id af79cd13be357-8c3893840f2mr2997446685a.32.1768321747192;
        Tue, 13 Jan 2026 08:29:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b9fc41011sm71902e87.69.2026.01.13.08.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:29:06 -0800 (PST)
Date: Tue, 13 Jan 2026 18:29:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 2/3] soc: qcom: ubwc: Get HBB from SMEM
Message-ID: <iqg6jpq4i3olwugnlnsczisbrbysxzik6otby3pgkv5uqsez3f@diwpjgf26mk3>
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <20260108-topic-smem_dramc-v3-2-6b64df58a017@oss.qualcomm.com>
 <you4xijwc5g4ngcnhxm4ecn7opexnsdfayvd5wiiqpl7734r7w@bdkpjqmlzxre>
 <b2pqfrs2ptaoxxeanzumxyibmydsoiqslcsg6yrm4hihynowj4@mzazqnrptnyf>
 <hunbpvbfkcxzbnwr676z6fncgdhfumjedx7jp5izojusg3rj7f@5te77lmqcdaa>
 <cleh7dolqus3grexqfchtavvnj6wef6rlslgv3r7gesfuyxhs5@5b6z5gwtn36b>
 <nhgxvv5bm3bevq4qkqnew6gaqlwiaicrs7yjckg26fgwnffqj5@u2phabfukljx>
 <befc5600-5cfd-4134-928c-80e3b1b4102a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befc5600-5cfd-4134-928c-80e3b1b4102a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=aY5sXBot c=1 sm=1 tr=0 ts=696672d4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=yH33JR1JA9jB6mUk05kA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: GfUL2HmThzzLmRUooZiUBHUD0K-QMpDB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEzNyBTYWx0ZWRfX3q3WHFyVwi/e
 eGm/Y48TUd5/QpQEtQyaeXHXjL1tn5y9II3Mh3EOIuyFUb0QBp6PWkmVd10vOfrssIwDc8ySZQM
 qxtUyXkmKEFkqcZr2uK/b8bkrt6uidofWs4AQA6uHrtx8yxDcneetSQQdygOofkCKWgQv1wGgN5
 oGuNVn/6bQoZF/aWvbaYAa5SLWz6qEMXOVUJOovHKtjiPUamgMUPeove9mwHeZN99WcjhfTmNI6
 FVSpojHMZ/TgqWushP12lre9KjR52PSngxQEPeQEesgWfUCN7uFt4IW913Z+L88gFQQHoEC+AvF
 Rwwbra9HbDcug/OCobs8wESMSPMlcMxSAdUWqTLtYoVMe+tidxYwj5Zuenu9FCME38bcrNl7Q3r
 +oVad2JjgiLyIFhMftsnN61uwGUshZ3LuudAprVdTiR6NJkwN9jDEEqDC7OT/IXx1y19EsPPjAW
 BinAvkzz2GB7aGaIpPA==
X-Proofpoint-GUID: GfUL2HmThzzLmRUooZiUBHUD0K-QMpDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130137

On Tue, Jan 13, 2026 at 04:31:15PM +0100, Konrad Dybcio wrote:
> On 1/10/26 11:45 AM, Dmitry Baryshkov wrote:
> > On Fri, Jan 09, 2026 at 11:50:46AM -0600, Bjorn Andersson wrote:
> >> On Fri, Jan 09, 2026 at 05:21:10AM +0200, Dmitry Baryshkov wrote:
> >>> On Thu, Jan 08, 2026 at 11:49:54AM -0600, Bjorn Andersson wrote:
> >>>> On Thu, Jan 08, 2026 at 04:45:49PM +0200, Dmitry Baryshkov wrote:
> >>>>> On Thu, Jan 08, 2026 at 03:21:51PM +0100, Konrad Dybcio wrote:
> >>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>>>
> >>>>>> To make sure the correct settings for a given DRAM configuration get
> >>>>>> applied, attempt to retrieve that data from SMEM (which happens to be
> >>>>>> what the BSP kernel does, albeit with through convoluted means of the
> >>>>>> bootloader altering the DT with this data).
> >>>>>>
> >>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>>>
> >>>>>> ---
> >>>>>> I'm not sure about this approach - perhaps a global variable storing
> >>>>>> the selected config, which would then be non-const would be better?
> >>>>>
> >>>>> I'd prefer if const data was const, split HBB to a separate API.
> >>>>>
> >>>>
> >>>> I agree, but I'd prefer to avoid a separate API for it.
> >>>>
> >>>> Instead I'd like to either return the struct by value (after updating
> >>>> the hbb), but we then loose the ability to return errors, or by changing
> >>>> the signature to:
> >>>>
> >>>> int qcom_ubwc_config_get_data(struct qcom_ubwc_cfg_data *data)
> >>>>
> >>>> This costs us an additional 16 bytes in each client (as the pointer is
> >>>> replaced with the data), but I think it's a cleaner API.
> >>>
> >>> What about:
> >>>
> >>> const struct qcom_ubwc_cfg_data qcom_ubwc_config_get_data(u32 *hbb)
> >>>
> >>> I really want to keep the data as const and, as important, use it as a
> >>> const pointer.
> >>>
> >>
> >> I guess the question is what are you actually trying to achive; my goal
> >> was to keep the base data constant, but I'm guessing that you also want
> >> to retain the "const" classifier in the client's context struct (e.g.
> >> the "mdss" member in struct dpu_kms)
> >>
> >> If we're returning the data by value, there's no way for you to mark
> >> it as "const" in the calling code's context object (as by definition you
> >> shouldn't be able to change the value after initializing the object).
> > 
> > And I, of course, misssed one star:
> > 
> > const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(u32 *hbb)
> > 
> > This leaks the knowledge that HBB is slightly different kind of property
> > than the rest of UBWC data.
> > 
> >>
> >> You also can't return the data by value and then track it by reference -
> >> as that value lives on the stack. This has the benefit of making the
> >> lifecycle of that object clear (it lives in each client) - but perhaps
> >> not a goal of ours... 
> >>
> >> How come the ubwc config is const but the hbb isn't?
> >>
> >>
> >> If we want both the per-target data to remain const and data in the
> >> client's context to be carrying the const qualifier, the one solution I
> >> can see is:
> >>
> >> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> >> {
> >>         const struct qcom_ubwc_cfg_data *data;
> >>         static struct qcom_ubwc_cfg_data cfg;
> >>         int hbb;
> >>
> >>         ...
> >>
> >>         data = of_machine_get_match_data(qcom_ubwc_configs);
> >>         ...
> >>
> >>         hbb = qcom_smem_dram_get_hbb();
> >> 	...
> >>
> >>         cfg = *data;
> >>         cfg.highest_bank_bit = hbb;
> >>
> >>         return &cfg;
> >> }
> >>
> >> But we'd need to deal with the race in cfg assignment...
> > 
> > static struct qcom_ubwc_cfg_data *cfg;
> > static DEFINE_MUTEX(cfg_mutex);
> > const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> > {
> >         const struct qcom_ubwc_cfg_data *data;
> >         int hbb;
> > 
> > 	guard(mutex)(&cfg_mutex);
> > 
> > 	if (cfg)
> > 		return cfg;
> > 
> >         data = of_machine_get_match_data(qcom_ubwc_configs);
> > 	if (!data)
> > 		return ERR_PTR(-ENOMEM);
> > 
> >         hbb = qcom_smem_dram_get_hbb();
> > 	if (hbb = -ENODATA)
> > 		hbb = 15; /* I think it was default */
> > 	else if (hbb < 0)
> > 		return ERR_PTR(hbb);
> > 
> >         cfg = kmemdup(data, sizeof(*data), GFP_KERNEL);
> > 	if (!cfg)
> > 		return ERR_PTR(-ENOMEM);
> > 
> >         cfg->highest_bank_bit = hbb;
> > 
> > 	return cfg;
> > }
> > 
> > This potentially leaks sizeof(*data) memory if the module gets removed.
> > Granted that all users also use qcom_ubwc_config_get_data() symbol, it
> > should be safe to kfree(cfg) on module removal.
> 
> I really don't understand why you'd want a separate API for hbb, if
> hbb is already available from the larger struct *and* if a driver needs
> to know about the value of hbb, it really needs to know about all the
> other values as well

Please take another look, qcom_ubwc_config_get_data() is the only public
API, qcom_smem_dram_get_hbb() is an internal API.

My goal is to keep having UBWC db which keeps const data and which which
also returns a const pointer.

-- 
With best wishes
Dmitry

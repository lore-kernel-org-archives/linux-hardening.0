Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B11205E25
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523737; cv=none; b=TNJqe1NdyWDthx1/x04rlGSrpAasSkdETbCI8ST7nSZGgtESuK7oousQR7Td1RuTsTpcYzf8WRJYpilHCUTwHznH+bnfJwxRjkHOZIwNNExhiUQkLNatdkSL/S3LGYOLweWHHP1qFmGjojfHG0Kk0kuBZmv4KOKJDjb29y6+kWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523737; c=relaxed/simple;
	bh=iAmtRqGPeR/S9VjWwZKA1aPJW+IrV/cIuDNCInOMnnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Agv1iyy13b/ivw3ynKFMIFsa45RymAgz1lrjhhLXHP/ttPkR9MCvXPAa5LNksI0Xry0iEHIwt8H6AJvtRiS909CsjRvjjrk8Ou7EI2QPv1Gg5g6+kisMDxmej78oRQs9kGnmh09swknW8YLwoHuWfa/TqTv0gRehEOMyKWAlvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1LqhODG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eaRqjjOl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1LqhODG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eaRqjjOl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RA02jP184765
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 14:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/zZBr4RQMGR6+8mwWzOZeCwVTQSBGms3epNbHc/lK4=; b=U1LqhODGZjRjomPG
	kj2Tn0IW2gH/YO2UfKr1oCd1wYuDd8oHGJPP66qCoKBW2rZAtmI6N3CyX4zEoqZ0
	xgsTESoghkgenLSBdK4vD/HQNat9JV6ESB+xedzP6a/TJf3HO6woc8nf/+QE4RP7
	VMcd3joH2Ony78XdvoNGaBcBkKWvAADACa3KDYdpEXzl1KaQtjtis1Al4jgWy7w7
	kSUMU4Wy4epR6XpRbAtD1gjaV8VqUOBa5RyRTogDNIckxCcs7HoThn9io+YubLtQ
	KR9g8m1fLu1t0rxLE+GXFROHHhTXhryhe71uvxkaGeo1Jw6nHsCvgP6pSl5v0MBG
	28zFhQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdv9kbe4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 14:22:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c522c44febso83835685a.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769523734; x=1770128534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/zZBr4RQMGR6+8mwWzOZeCwVTQSBGms3epNbHc/lK4=;
        b=eaRqjjOlvxQgeJLFronU2HN1kKvlPznmpbR9QxcUmR1gZsnS31N+R5Ob2HTydlkfx9
         iD4HzxPWyLP6dJS/arI2Lxuk6SZNxErp1ffyOwG73iguR4r6e86953INcid/s2SiDGrG
         qOG5Buik1iv2OYilNyxGv0GqViPDd9913BJt/LiIOMr6lLhK//CluN2WbfjmlZSbapgQ
         JuUOWuymnGKGDH5WtwjmpnLLFglpIOf3sAsa3QppWoK63Cm8I4Uuv+gziEccG/ilEN6s
         0pvUr9oYdqOi8cD6Le7Ef8Yf2Nnl/tGYyGL3cOlx3AqD2obl/ILZo6tG8UzulAlpEOWu
         8gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523734; x=1770128534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/zZBr4RQMGR6+8mwWzOZeCwVTQSBGms3epNbHc/lK4=;
        b=fJEg+JiWji/CDK8aIk2js2lNOXez01iPOoK+0g+CfF9RZGOEgIjE9UqOiLxxWpYaXZ
         dGlLOO0tsx49QqJVqh1RZZ2+QuCZzTFZyC1z1rcgUF/XLDskyCGi0nfvrvTI7P/YDQBt
         HTH5R5PiPe+W3xXmGpunYRuYYiuwte8L0miN6PQzXck9hYTaToMme0gWRrba+qtRlgp0
         +zFNvtNACHug0b2JtngKaNbe050vrmIked+KrN6jd0EwowpIsmfbAYjS5FaCJexTik0o
         QpBb1e6tq9pcGW3MftHyrCJVeoAStt7XJ2mMQO7e7raOn73twt6QkgGO7gn+1Z0LJKbD
         gwpA==
X-Forwarded-Encrypted: i=1; AJvYcCUum/WePftEW0OOsQ25pCuHlgPi6zsax4HDFIqS729SW1CNPBaOQi0AaVt4fRKgSjkoGeUBdgu4ROT1q36FeiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbdVDour3b6xGFpdywf1bErdV9ogFvNJRDeesXh5Lj7n9nXWr
	mNDNp3EBiqWYfI6FfxMf5jHd8MRfn+8qYKpiIpvcoY8ZqW2IwqkKoY5lwgJwwc/Z24cYCqNewEg
	sYhtBWhtGmTQPZlZamvGGXjtzMoti4UsCeBT1BWAKEkuw0jGsOpbG+U4KSr3ypzR36ProjY4=
X-Gm-Gg: AZuq6aJWKwi6eANwxwIYI5CpTtG3RBjme4b4vRxeIFOaNdaUP9Srb37qyFZL39hcSOI
	dfVpDYWrjzQHq7U1nCoVceM7jWMH284GETuuP6EPNI/SzhBeQ9hiuqtiPKEMswm8jqokeMY/fwq
	kbfZLYbF9Dn8fqWcQE+ylfmM+ECQgi+hoOujAm2vVq75NyWVR6OHw8n75wgGKkj18BrRvpoiVig
	z5au+K4AEistM0LEIXkzjtbYfMev8qKaSKdT3Z+mIGAf8tq6IIGiOKFWJ2Wn240ZTBYOso1IKMX
	1ufpgYzcMfAEM3IzCKUxmOf+zLKmwo364ZbKcwGsfpYRtxaiqtT4U4Cw3IIEBunHgxvBHyXDgc+
	gAWVxEs9MmpA/xSaezCVnmFikSdJF4JRkJ7yBfdf6JfIK2XjX9ZWEVHpACjEVOBdCIdw=
X-Received: by 2002:a05:620a:178a:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c70b9046b6mr186421385a.2.1769523733721;
        Tue, 27 Jan 2026 06:22:13 -0800 (PST)
X-Received: by 2002:a05:620a:178a:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c70b9046b6mr186414885a.2.1769523733146;
        Tue, 27 Jan 2026 06:22:13 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b416ca5sm815011666b.25.2026.01.27.06.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 06:22:12 -0800 (PST)
Message-ID: <c243a067-c33e-4ada-831e-ec611208b191@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 15:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] soc: qcom: smem: Expose DDR data from SMEM
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <20260108-topic-smem_dramc-v3-1-6b64df58a017@oss.qualcomm.com>
 <20260109133612.ommcoivkbhbisp6o@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260109133612.ommcoivkbhbisp6o@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OYOVzxTY c=1 sm=1 tr=0 ts=6978ca16 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rBdmBs-3Ac6Y_iI8bpQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ViQXdn5iaUqADME2YdBm4M2aUOxcs9Mt
X-Proofpoint-ORIG-GUID: ViQXdn5iaUqADME2YdBm4M2aUOxcs9Mt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNyBTYWx0ZWRfX58nS4+K1LW9s
 mz434AuIVd/9wuBciyhu/LmEhCnXlFPzbcJBVi074Vow3gWHKmVqwrZeBI03dAJKKIsmP5x+V2A
 M4YFzIR0AJwbzFmiY854ax0iKVf+0OK3kqot3OLM1JMihD7CZOLdk9hhVGmgybxAkU8JelDJn3T
 RR33r2N7N6ow5qjYOXZRwMXcae1k7newbmbTKAgool3tqw4F9HTqMvtFzlVuk/8AplNJIci/DYy
 CypH6W7vT24rv6T1WdGUypRWdX/70RH56zF/0dTNFI8JwUCTgpPzQ7d0q5wKdgl0u421MFhcezp
 M7uOFZqnnt53ChnEOHSSzk8KiWm7ZaTmrOXoB+XoGuAbXrxh6qn8Z5q0Fa57Ic1Lzju4bGvtdKv
 Ui1jOCKAyGWfUsEmKH/6YIOBNZIJejVQmu6LTjZhxrOhZq0IlfJZbZCgYtve7mNxUb8OurXpzMR
 jrV6tIaqzS9g5lbiifQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270117

On 1/9/26 2:36 PM, Mukesh Ojha wrote:
> On Thu, Jan 08, 2026 at 03:21:50PM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Most modern Qualcomm platforms (>= SM8150) expose information about the
>> DDR memory present on the system via SMEM.

[...]

>> @@ -1236,17 +1241,24 @@ static int qcom_smem_probe(struct platform_device *pdev)
>>  
>>  	__smem = smem;
>>  
>> +	smem->debugfs_dir = smem_dram_parse(smem->dev);
> 
> Is it possible, even after calling qcom_smem_is_available() before calling 
> qcom_smem_dram_get_hbb() we are getting __dram as NULL.
> 
> is it good to move __smem assignment to the end with barrier so all the
> changes before the assignment are seen when somebody checking qcom_smem_is_available()
> with a pair smp store/release pair.

I think just moving the __smem assignment down will be enough, no?

What scenario do you have in mind that would require SMP barriers?

[...]

>> +struct smem_dram {
>> +	unsigned long frequencies[MAX_DDR_FREQ_NUM_V5];
>> +	u32 num_frequencies;
> 
> freq and num_freq_entries ? since you have used freq at various places..

The names in structs come from internal shmem definitions that I didn't
want to stray away from

Making the kernel-side struct fields named the same feels like added
confusion to me

[...]

>> +	if (size == sizeof(struct ddr_details_v5)
>> +		 + 4 * sizeof(struct ddr_region_v5)
>> +		 + sizeof(struct ddr_xbl2quantum_smem_data)
>> +		 + sizeof(struct shub_freq_plan_entry))
>> +		return INFO_V5;
> 
> Why this does not have separate name ?

Because it's the same DDR info structure as "normal v5", with trailing
extras that we don't really care about

[...]

>> +struct dentry *smem_dram_parse(struct device *dev)
>> +{
>> +	struct dentry *debugfs_dir;
>> +	enum ddr_info_version ver;
>> +	struct smem_dram *dram;
>> +	size_t actual_size;
>> +	void *data = NULL;
>> +
>> +	/* No need to check qcom_smem_is_available(), this func is called by the SMEM driver */
> 
> This comment seems redundant..

With this one specifically, I don't agree it's obvious..

Konrad

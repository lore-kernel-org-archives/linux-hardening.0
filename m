Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304192FF151
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318328; cv=none; b=XE5mZjuMvP7mBQxtFxvzV69+zBPctOgMVBmh3DMqfEtDAUysZOD7IXtCHgTY2D3vrHHBagGFX7OpmxVq/st8j9/oMjpr+5ffTE0H8gXCofrsp2X8eVstXR0nrivx+th57nb+xV1tITV8U44jXBnMKjugRXKveNdQw+4PDnlWUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318328; c=relaxed/simple;
	bh=pzb4n9kTdNmTjQBVJsD9zbv9nA8yjNDcG1fjBwljgE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWsgdV4UyDDIFrPTKwaWK6etSnPw98IcAggca6IfFepfTaOhK5d36XPGK2XebEpNF5rDwFkuIPvraC6TT7OF6P0J3bPc9E6ZeySvP65OyRqfiheMpDjmogO5/BW6CpABa7OFQVpvrQuGhRmBlXtHFl2o2kHw9njYUbj/Tu/hlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TXl9sfUM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W82NFzjK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXl9sfUM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W82NFzjK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DCoxf33868780
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 15:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ccl5y1POfshQ1u62vw6ufJB9tUYIx6XdcUcwQWB6apQ=; b=TXl9sfUMemknR8Mb
	76dTHbqO9lU1cgVVu25AZBNFAbO8f29gSh/HSGavmO6E0Q0Rch91BuzQZsgedaac
	vMghU0Nj4JHCnjyJj/rnMYLr6FDzRdvMSfW2YqPTpIYYnrxqwJrWNv0iMrarGHyk
	vUrMKq42wnUMobiK4oNaBFsu7zptDat6068H1YHfNuAo3BUm11WIcFJgJmEJxlbM
	a1hvcOBHqJBclj+OB6BxxwawEB4gQJEaN3UtS6uRvOxvJafc/eP7spLP20DG9VoG
	zEUIdTWtuyTuDhtm22YskqAjLFLxcXQ5PQQCjd8dUtKZ8sB2hwopcVG/1wG1ZACE
	46ytWA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnfxk9tr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 15:32:06 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5efb28afa7cso151755137.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 07:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768318325; x=1768923125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccl5y1POfshQ1u62vw6ufJB9tUYIx6XdcUcwQWB6apQ=;
        b=W82NFzjKjLkmoeX+Qpp9EPIsDkNR6+/J0wAppTC0q9kAu6RW9iaRwrtoISECN4syyk
         43Z0yYEE9LntHstS6uc6TdKzMa7nflKSC3fyqJvTlT0HzhpsZYZtGSOMiJXbzOHbcyqh
         i5gdWBebFptfA60G6GU7FXCTzW43rUyi/G730O4Fka9Epp0s9PdG51boQ9dZDNsZ2utd
         z814FJBF6nhNkJsFs9LiUwyiokQGKP/tQrIXKL62w6IWEPbs3yNL/6MhKW7AXoydXFKm
         IGS/vWzpDEbRRhLJglCQVUY8bfSYwI7QBUUKreMHeQywLudFB3Lm9mzWI1DLWxgnsxUs
         i79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318325; x=1768923125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccl5y1POfshQ1u62vw6ufJB9tUYIx6XdcUcwQWB6apQ=;
        b=mO4PbH7MDBa/JUcHJdUuXNrV8+zQH7aSA2sn8aTXy+24PPaOLde4SZ+W1LjO66sI5M
         I4F5b0DyvuSAUMRuJpyK2AvAvKYA7hx9mopGcL4UhIXsUXqQSUZkRozPmhoUcOmGcog7
         WaVBB8JUfLS6e8Dq4Arg6eMFN3RrMV2CChI5WCT5hkPcArAHNHssOxk/3+A5yKx7ZKrs
         j/s43wOepiOHID7LmyB5sOv+tJEKRGXUcVPdZrq4MZU6RqrZgxJ2uVNAgQNtkIqx6uUW
         2bGjmes3k64WdwnRGCxf5FgjV5IAM2Q4r+yqGbRVb9WYNNgg0AYoxOsqenbudkn+UURU
         Gp2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBrNzBX5Fhj54UkEUdvhHXK4/EnDIk6SKk/AKUklg6LKUss/IuEUK9jIX+/d4enHaDtN75EjTsazwDuSIz7FE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1tz8yenMJzH2Cg47hYlKZTuJ+r3HYHgVBAM0QhV+O5YnHmHR
	u4odJLCswiIU8Gn+huxeFi6Ra+qdG7WxwedQaonh/ybDmUmAdUptMI+EOg6MRZYkpNS+D9nGXhZ
	z1ENmqdD1wFGp+3t6o+OllP/KpGgfeow1BcnnWcnSkyfLViIfCltKg2xAZWTV96sZkljs2gY=
X-Gm-Gg: AY/fxX5zbbuhSR28Zi/35/ERmhFz7SPD+BG4Tg4EREJS03Dac+wjtK0XecZELdwfFud
	6cETZ5rnwa7d8+K97JT4sLKn0DDWsDd5Kg8LRw6Ea7xuokFmR9h4jGc4BHQ6+ZnL581ZVzyrWKx
	bMBmBbaGjhuwB+C5MacXabL5eUF6VIJpqQNhOmMnSLqmFFBFntbjYG+QzoIDz+dn18UOAH01F/6
	5GCJAw1WfCTFzjw6mJiHRlEwV3X2biaRo8oLSnYNI0VSelFJDOMSb14U7arLvxbu1+U9/QA7kYJ
	/v9N6B86HA5A/OvrUELvIwvZPSThOSg1FwqVlyyWty+JCp/48VH8q5u+s6u+Gl8TuuaTUtGz18h
	L+xp6UrohCHzGJSJLaEFYuR5fqHM8p4gU8g/RcI4CTPVJ0pS40hUh0X9ogZWeJQEHlLk=
X-Received: by 2002:a05:6122:9003:b0:563:42b5:457d with SMTP id 71dfb90a1353d-56347fdbc21mr5167772e0c.3.1768318324037;
        Tue, 13 Jan 2026 07:32:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDxp+V1DqoIerolnxPkbDym8KjSTKMypTINzAGYcZIuAStLsVttNXF1ApjLb6xX+Kb3BXSCQ==
X-Received: by 2002:a05:6122:9003:b0:563:42b5:457d with SMTP id 71dfb90a1353d-56347fdbc21mr5167689e0c.3.1768318322712;
        Tue, 13 Jan 2026 07:32:02 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872152ee10sm534347566b.34.2026.01.13.07.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 07:32:01 -0800 (PST)
Message-ID: <0f786783-db0d-4bae-b3ea-cab2ea85223e@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 16:31:58 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Retrieve information about DDR from SMEM
To: Connor Abbott <cwabbott0@gmail.com>,
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
 <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GpWhma3m-hzGzOzwepgQV-eHm8Q72ufz
X-Proofpoint-GUID: GpWhma3m-hzGzOzwepgQV-eHm8Q72ufz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyOSBTYWx0ZWRfX4l6123gg+fNI
 zLxvS0Bjhw8OCxPEilo5D3OvEh8NXWZqDyozmG7zy0406dyLrRUQBOx4yoz9GX4IPjWoPxi9TBU
 tPY0/NuBM5o/Hqyy/LtAvdn+BI7EnONnKQ7nl2yFeq8cgwLd6C9FIvATEUgrcToM+Y0AdtQPp51
 GsShZzM1kKcpDNaDwyzpTnlCQQioa7sDQTNkR/Y37s7v8ZwhpjANvpO+KdKuMKZwoJzzaAa7pQF
 ZJCewOOXG5rvKhha8K/yxZ8IWvx3m+dqTCh6PErVC0hsBDZ+tSIbjVrS05ollA/5yf8fyd0MoTq
 sv4pYwOGwFErfqtx6VToWYWfz79LjTwNtQinET+c5Ltr+NLuRJmRwhbMtmuZytH7cg4kV5KPUM0
 SIjLGZmao5roSlc2PgGhc/gz21CF1JKXklDgOurfsNIrukOJPqtPAToDs3xcxhx41qB0ZvuW1ST
 5M4lMsOi7RF5p/1ZdYQ==
X-Authority-Analysis: v=2.4 cv=PvSergM3 c=1 sm=1 tr=0 ts=69666576 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zvAHPaQ1O9Bprg_nwmMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130129

On 1/9/26 8:11 PM, Connor Abbott wrote:
> On Thu, Jan 8, 2026 at 9:22 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>
>> SMEM allows the OS to retrieve information about the DDR memory.
>> Among that information, is a semi-magic value called 'HBB', or Highest
>> Bank address Bit, which multimedia drivers (for hardware like Adreno
>> and MDSS) must retrieve in order to program the IP blocks correctly.
>>
>> This series introduces an API to retrieve that value, uses it in the
>> aforementioned programming sequences and exposes available DDR
>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
>> information can be exposed in the future, as needed.
>>
>> Patch 3 should really be merged after 1&2
> 
> No. The HBB value currently returned by the bootloader is *not* always
> the same as what we use currently, because some SoCs (like SM8250)
> with the same DT ship with multiple different DRAM configurations and
> we've been using a sub-optimal value the whole time. After all, that's
> the whole point of using the bootloader value. But patches 1&2 will
> only make the DPU use the bootloader value for HBB, not the GPU. So on
> one of the affected SoCs, it will introduce a mismatch. You can't
> change anything until the GPU side uses the new ubwc config as its
> source of truth.

You're right, sorry for that

Konrad

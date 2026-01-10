Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D6318EE7
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768042166; cv=none; b=P8cLDW5T+qYuCoaiVZDVJcwDkFhbVuMP+JyP461K+xT6f2/fs3LGhNerUfb6bBvYVEzdXo9GUXW3kU18dvAooNaeg5I8yD8DDYdTXBNv3ykOvBTVebNR9jmHkKtV2FdCwPCkYtX1pxv1EDoDkD6Uz6cd1Viijmy17NrvC0xS6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768042166; c=relaxed/simple;
	bh=TVrLvv3KRuw8HTHhGsYlecraiob+Df+JRMVLgsV03+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYFZlpEUORmyjHVNSZhKLJ+7rIyNELS2FHv4Bzu1syf42wWMJTaOIvCMiF1g0nkf0lTZhopwvQJqjMKfe6/XgLmwqjqAmTuLfoXcWW6UZsJXbCoY1933XLAQtvEupxDZCEzKnKmgOvk/0RMhuo0/3XT6rh+apw8eUf2Fi80tvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZOwtVvl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hBzz1JzL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZOwtVvl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hBzz1JzL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60A6e20W3479246
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 10:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qmyd2kMKM3XJIp9vc9VyDMDqUbQI+3X1Vq4gSHKjf34=; b=YZOwtVvlufhUUSlz
	GScp+O4/+2G+NC67m3sAXuUnvQEBKJ9aDSR3XkAJeumVG8fXvtK9P6o6tJr02XtR
	gvGKqvz+p7DW+MXPiNZUtQQDbgj37GWJsJyHNY0JhEHfgKbEkw2H9l3h3GbVh81l
	eWgkfrybbgfy07E6+yeDPFSMEelEk9vlv72jbezfK164e/bR95g140K/Ihp0Wxw9
	34l1W8B+QpW0hThYk5N0jbijV6O3tSRk9Z7XZ9hrRJ5zSoLqTc/P62c6fbvGIQtF
	U0MljPG4j3Tf8kX912Es+/pBQ3iJ1A1FwRvSUE0GiHaAqnQIkFBrCWGoa24IXe+r
	QVmXGg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkeusgj6t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 10:49:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bb3388703dso1923925485a.1
        for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 02:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768042163; x=1768646963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qmyd2kMKM3XJIp9vc9VyDMDqUbQI+3X1Vq4gSHKjf34=;
        b=hBzz1JzLcciVFgxe99Ck1ieqskaOdFxyFfzGlrlEFZSKqb7LNaM9kBmNg0F72IqxnC
         whHHMJ+0HLHMnkQfxv/6z3xA+pggjuRhOoCl1Mbp6Itt52mCJRBYBNnXSyHxyUrWEPIy
         g8tw9JwwOu8r2OVHJxuG4XfMFWM1SRH88fXQL5C3OkR94eBZO2PrDFoeIJ9An9rS4MU0
         iuJlP3BpA8OdCDuWt8Gy/3o+znufL49y90+pNvgixS4tPtyBB6dvX2LCvCWPoUsjMRSJ
         rG73FsPjv9Vl3W+uKjaxXl8GE06NFTGMKv5XwwbBYC8SIsgz12b5j+ord10Ea21wubKE
         3idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768042163; x=1768646963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmyd2kMKM3XJIp9vc9VyDMDqUbQI+3X1Vq4gSHKjf34=;
        b=Ehch+akxbMfhIUFMRjr/1xp47sgnf+zFTDg3emNWZeiimTXM+8q0CMOhSlWChoV7Vt
         J7EhQpzf5I9c8f7EkThkZSq9IyYrIR0n2FMLdOoFSP01AWoJCSBnwiw6i2wwl8r0GL3x
         Ydv9zYEV1jxZmU5wf4Rqo6EYS8GisiryQ4pR8aqdG8iyJox3rT320oU37OGpIPOW0eGz
         OuehNAKFbhxLUh784WHaUfttEQqDBPqWVGn8d8p1H6pLoJXZF3uj0yBp+a8x8g5x53lW
         xDbPJhTld2VIL9g7iJxZomNhw4ygDKKbmADwuxgvKl25NG13bOS/rUfL6tY1/4vI2RM9
         dMrg==
X-Forwarded-Encrypted: i=1; AJvYcCVUwVvP73tPv58sTjEwAlcp+9Cm1Pfib1Pov66JCcCWt8WOJvTOauV31uAUI6qKbp6buc0jfgILqZ8M4AMl7eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwharADimN/Y0CZ0b8cdymv+Roabq3eTh6aNfEcB0TF90f/KGEl
	k4fkliCqLVF7IZri5h38hz4Viqoef4xLHGOyq77q6XzaTRiWYxU4/DsEv1V4whYFMRAVqYg3Kbt
	UpW+5mMM/d3hF4X4A0+0KBRm9ZeMlAY27BRCXf0vJPnzJ3UcMqaXTTEzUwo481BKNwe7sJyA=
X-Gm-Gg: AY/fxX4ShN6Rg9HUEfHPaH+C0LKm6kofVsaQcU+BLFaeaWlhiztwjHHzAfadFHz7AWN
	DgZOnrXuNR/zF6dnPf9ZzXzrFz4tmq5KB/haBiay5YjYsSGGHqmo9nxcBra7N1j207xPI1CXLaO
	N9/cT44rKp/8BmmRg0gqVU/JsZczChgsUG/D8YX1Hh0gwAJTv/o9mQsNP50j/kkQHgSHLGBjdIM
	5EqQvzxWZfH27HfC5/pr2m9HlApfr7nN0jJOpnL4fk7td5IW8LZVeJ6Z/HND+TlJQURVOXCPNrG
	DnoTqlAB59iAlqFNowO0hW8yCn8HKAOMxihVr8lSKtM/RiGYAjJkomlxxvTd8+sb/nuAzcxxGVH
	k3QpUOkR2YVQTbLAjtNej1qjkOK8xUhEmiqgnS9cwGvSikhF/TFJxzLp7arsMX2uwUGlc4af+Ml
	bEA41UrUktHkC+yVyEv0uW3rw=
X-Received: by 2002:a05:620a:bcd:b0:84a:5f9d:a30c with SMTP id af79cd13be357-8c38940a543mr1820902985a.63.1768042163077;
        Sat, 10 Jan 2026 02:49:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfeYlGLK0NEw/OBCDV4qXGiGbgGdvJV7eookMNOuUyzTILnGIZP4lkEf6FU0K3A0WoIhxGqw==
X-Received: by 2002:a05:620a:bcd:b0:84a:5f9d:a30c with SMTP id af79cd13be357-8c38940a543mr1820901785a.63.1768042162681;
        Sat, 10 Jan 2026 02:49:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6ae8a169sm2967859e87.24.2026.01.10.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 02:49:22 -0800 (PST)
Date: Sat, 10 Jan 2026 12:49:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
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
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] Retrieve information about DDR from SMEM
Message-ID: <osefa4qfbezj6vxdjtlbnw2fhkt6ahbewt5xrpg7qeeapgwohr@xm2d6ati66nt>
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
X-Proofpoint-ORIG-GUID: a_VzJBjeY7lM3g4uarkrY0Z8Tc58sht3
X-Authority-Analysis: v=2.4 cv=GNMF0+NK c=1 sm=1 tr=0 ts=69622eb3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=9BbF6PmzOO6rjHPDYboA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: a_VzJBjeY7lM3g4uarkrY0Z8Tc58sht3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEwMDA5MCBTYWx0ZWRfXyCtFXqoHSEw/
 EdREn3pteOYYT3hgPURMDbzx4DwNNQ0fBPA6HRINQfxK3HpX6pfSBSNzwjhjGvKxAb6K1IwF3HV
 rptmstIN98cx8q/h7DE1hi2AiICFPpKhuZYiqcivFo9BZhkEkn6BkSV910zSWaIGo8k3lwWXU3x
 IJmoOB9LcPnaPqQ/hNgn2O9Jk0b15urJQiErM5UqSs9uirpCuKlTmx4/Y7hGumO2Z+HO1Mxpqpi
 WkjCHfn2kmut7OxYiSu5T61GYdAUZ2nH1rTfMHXHosrCoFK6ku/OarxkdtGtJPYx2lQ3DxDNyVf
 3Yq0EAEv8k6cJr1r4NzQmk1SQ17p7S8PWwP0w5BEzfIdlwIJ7CkO/v0KYuwfhoaxBTnsH5iieoF
 JOcsirCfouh8Oht4lD7bvwS4TZhilJ+MyJlBQmaYfkoTXVWTTe8tuaZUfMPqI2toM9UjZRxFL1T
 87ZTlMtVgrtb/LtbM6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-10_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601100090

On Fri, Jan 09, 2026 at 02:11:19PM -0500, Connor Abbott wrote:
> On Thu, Jan 8, 2026 at 9:22 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
> >
> > SMEM allows the OS to retrieve information about the DDR memory.
> > Among that information, is a semi-magic value called 'HBB', or Highest
> > Bank address Bit, which multimedia drivers (for hardware like Adreno
> > and MDSS) must retrieve in order to program the IP blocks correctly.
> >
> > This series introduces an API to retrieve that value, uses it in the
> > aforementioned programming sequences and exposes available DDR
> > frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> > information can be exposed in the future, as needed.
> >
> > Patch 3 should really be merged after 1&2
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

Which, unfortunately, also means that Iris / Venus must also start using
the UBWC config API beforehand.

-- 
With best wishes
Dmitry

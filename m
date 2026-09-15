Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274747D462
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465909; cv=none; b=YpQn3foVW9Xx+VkmwSY+sH77Mg1xsGEsG4bvDSoB2nPlkw7fgF5wV+maGQWlzRAkQK+Pzm3QXKjawh0z6AIbfkt0JUfcM4MsWXlEICdRs20ejo5AG8UV+7+La9REFrq6wKxsHKOnVf7xKlRnUlWiqsllE2aZCYwCrNYDgbW8D1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465909; c=relaxed/simple;
	bh=fsv5FuQjdenUC/MA7KEcDcRD5qJ+JKikKx3HzE58Udg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0eq1F8/xg8yqPX3aj5E3Enj1cF/LtBJ7us2wIQkgtDkg67AC0Hf5vYlp8gsMpAIXgs2eKPiJP80+D0XgBSvDY5dEnPlGnJvnX/3mvtLV59zSceWF8n7KXa1aWBLY35dS5bW4cvuEuThuSylnfV2Zq/Zj4inMiN2ArmsIbEgfb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CI8gvr/1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T50S8B/m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CI8gvr/1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T50S8B/m"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F9h7s53415788
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 09:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m1XFciMC/FLa8VakPPfRy3mt
	kacc3Afj+FPNQf0K3uE=; b=CI8gvr/1w5ZXZRm38i+8BGRL88LIfWTnN0MqNM8e
	L+61VU2lXgzj8J7GVB6+g5+zLW1gJxbmQWVmvYRDteXttBIHoLWOHVmlUEPu29/A
	Y+taWVgNqPwHl8KW6fcDSrUUgOl9FAWMfk0c92p00UWd5a+2cNHLE4wuvYP2H4H4
	hP9rm3BslPj98pVC4i8qek5qWxRbNGgYN+jU2NOGruhzl5l5jy6ZVPLnhn4mB4ep
	FH+QsCovJGjapiJnqpChffwKXZkdK7Ra6JN8IXFlzghDAbHIzKgRgFQ8pFGdpUj8
	J+7L+v4HBvMXUHLGlfCLD6vybnqAcIypHxGNtS69f0A1Qg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc02hg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 09:51:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939d6c515deso865106585a.3
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789465906; x=1790070706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m1XFciMC/FLa8VakPPfRy3mtkacc3Afj+FPNQf0K3uE=;
        b=T50S8B/mf9KarFy/9tnh/e0gADLD9yaZuqGjPWYnx9KybHN+c6cdRlUO/IT7fBILTo
         aTGFbNXqt1tDXBUO4NSvEzNKs0YP1hzA7nPM7YrP2E9fDS4wSf/IOA7GbjGYZw06HJ11
         tRAAv4fNYDqUSBU64iOXYUkPslPJt4gew6bsCr5iMjFEoPxPmx9XhPMkqBGI2hzsOS7w
         +LueLqfLNCsnWRND/EGqNXjcuMoBaGS+Tpu08VXa0HqkVGZ61xAG9Tzyk1n+wG9xwm4F
         GmQF3TaPtL/kYT/vPDhir07kyfiqQzwK4FGGyQENn256mouggQ1Ovu2397QIuxn3QXsO
         Wiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465906; x=1790070706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m1XFciMC/FLa8VakPPfRy3mtkacc3Afj+FPNQf0K3uE=;
        b=DfVyInpMoCKmjB5VA3lPJyKViZ8eQ0UkT4DMdfe2RsJCZub77g/rD3Aeh7+Dfp+uFF
         hCTB4mPWqXn5nXpl/PpvI5hkBpn1qPW7jDQK+kEIqq84z422ss4UVYRhwGRLeaDCU1sL
         UibeRi3tt++fKiva96I7PXANtOyNLZV33OJjn/pmxjFaGocd82pU2Ys1j+H6P+Q05aos
         KgHBcbrkWX6IdlOIh+R3eUmjbsI9ZD/ezGVTvgpi1xbd4pXxwaVjVu4s397nMe3UdOJR
         w7MxF1iOCrwemw7FfJ+6xjKasdvo4oFlj3Xx7Pz3a2ICIYSpiXhBj1cWE7gZbZsuwGkd
         jjCg==
X-Forwarded-Encrypted: i=1; AKwUvByyu6WWi3j94WRizuW5Ls76/3Ftevy1trYFTphN7nnyV+x/xApZH9LzRpsntNwrFGoqf6PK7NiKIGo6xuIwAQg=@vger.kernel.org
X-Gm-Message-State: AFuF++lq+VVNkz+ETqD48B4UYANY5Y3q3nfypJupDSgVSlzf8yYD7Cu4
	mX685YSH2aO0gy2GDCT9SeuL5O8o70BZs+EefpT2NGTiNg4Pdt2noMF+Zc0u91EUg0orVXgCq3E
	tAOHvESa8TfOmRglSqgje1jyUNTQqDq/z73f0nVZV/M3DS93jIytRsEnWmLE/3dvxe0GFmos=
X-Gm-Gg: AYBFou170shOokrWy7X3BnkJX81LkpBDKTa0gWxPSVm/79MDcJzmsukyoLhkbfpU7uy
	k4SKK8dZ4TVfpEgJceYZp1s7dtg0oUu/e1Zf6xCxEBgYYjjSD8OsvZX67vl3fAzx4bj/lMVjpv1
	05MO3Zizxqn8e4iWBs3XF19CGT7aSI1FB54LjcPailRngmx00FGIJG8eqM+49icU5BQo5xfkJpb
	hQBKQlPHgF2XQbuZulY4+ayRaBWoY+KdddZkRPB43ueO6CYQ9QcrPrWwqKDLFWS8k+Cpm8LfXZX
	6XTAPnGKo8wxmus8rZDfkRiY4BtaZDOgB9kGY5Eqhm/3vwaV/mvJ7BkRaDAxwXZmOBZWlQ3vO/Q
	rVzfBNvxcfKULQ7Q=
X-Received: by 2002:a05:620a:601c:b0:939:c555:efb6 with SMTP id af79cd13be357-93a29838e3dmr882760785a.12.1789465906055;
        Tue, 15 Sep 2026 02:51:46 -0700 (PDT)
X-Received: by 2002:a05:620a:601c:b0:939:c555:efb6 with SMTP id af79cd13be357-93a29838e3dmr882757585a.12.1789465905439;
        Tue, 15 Sep 2026 02:51:45 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35f3d9sm32642467f8f.35.2026.09.15.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:51:44 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:51:42 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v7 8/9] arm64: dts: qcom: shikra: Add OPE node
Message-ID: <nu5u3hr7erxzd5l5g4xnktdnnl2w43tjt75la4tkq4ddv5mfbx@npts3dwmx6wp>
References: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
 <20260915-camss-isp-ope-v7-8-77b13d131d3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-camss-isp-ope-v7-8-77b13d131d3d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: iouMbj1xrkP_9o8bQLJ3OWIvpR9lipfN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE0MSBTYWx0ZWRfXx48IPhZ+Q3rp
 hx2qPQ6Gqk4fuAFwbJPDrP2XS7tstLn5ieAIzmTQCv1LWbBGe+d/D5IOnJ0J59s+FlHkAaOOFDt
 SvRyYiDCXrXwG38azebEgDGvGhVGAi8=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa91533 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=I_ukrOqQsWpVYGr8uL4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE0MSBTYWx0ZWRfX+0natCtQ2HwE
 qLH3tQLojYYZBcr9GfFrLdtCLKmgdVU0uTAqvp2zeRVRXhzcpeh07tfhRWw/L1OXCmyDWAjXqEm
 TDpby2hceuoXgDdpHFVdLjbG+2R2pIls/T3z2i7Zm7RR8mCpkcJXzW3YWQQCXCelKFWMrNAzqKj
 JVVh54AADQ3CkWLERbqIJTz+E7DoRPsnCuE/mNlJ9FY3UDqBsE4h2o1crjna3NAky2dVB+suM95
 H1e6w1BCwVCa+O0+q1m6FxNqThoPD6svWBtXZ5qO4v9OJX7YE65Y2deEOFitcw2/Ols9wvUvx4R
 1T0v+AeP/68WlKrR2i0Qm6kiONJXl3RzweCOR0OzAmaNDIJ5r/hyP4GAcoCgmtinRbcZjDowU9i
 zzYTFTBzqufDin+RGS1sYpXn3o/8Tftyk9QySGtYTVGa8oC5GsSh0JCBrMWpOofOBcPn+uMgn4x
 8LMQtDIp/S0FWj/TZUw==
X-Proofpoint-GUID: iouMbj1xrkP_9o8bQLJ3OWIvpR9lipfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150141

On 26-09-15 10:11:11, Loic Poulain wrote:
> From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> 
> Add the Offline Processing Engine (OPE) device tree node for Shikra.
> The node describes the six register regions (cdm, top, qos, pipeline,
> bus_read, bus_write), clocks, interrupt, interconnects, IOMMU mappings,
> and OPP table.
> 
> OPE is a memory-to-memory block with no board-level dependencies, so
> the node is left enabled for all Shikra boards.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

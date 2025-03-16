Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9A19F11F
	for <linux-hardening@vger.kernel.org>; Sun, 16 Mar 2025 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742167483; cv=none; b=ZU8kK1QXWtTz1jp+AV47EDUxddBH4kg6KOoIcJjbHZr3LcA+4fUrizpa5mqEgvIJbaJXDE9W4wVft178Tu1nv2CwpLk3KpLAh5+JcpjX6dpBlPcFJcYF2VtfFhS0EXu3YEmK20hMWxQmMTS6BWtxT8gVxmCWHsblrovPjzixdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742167483; c=relaxed/simple;
	bh=csBmAWx4188LdtqFCso38hP0iT5E9pWN1eYO45SYy2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRdc5ZZtblfvnP2uL3v0kkLTsXi4u+4K6ouaHfyK5OoTuIAHZA5wO8VbioyKiWCTovjLA8q13Qrra9WKr3dgxmrlqjOzhIedYmMyahTbdetC2FEg7veaWmkId5RcuE/vcgj8To1EJ2zt04mFDzhTCNBCJJUO8xYnBQk4A4kJU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BfZ68ByC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfZ68ByC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GMUZfE030364
	for <linux-hardening@vger.kernel.org>; Sun, 16 Mar 2025 23:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IVYXHxBH6seE+vmi8RgMEu0w
	KLEvS3tZo1XfgA8OXEw=; b=BfZ68ByCOmnnxz10F5osrpHSbDwiSji/extGaB9A
	8deqDFF1lB+h25FkuLwl50I/oP8MsdI+kJdtRKebamF1XjN15NJE9FgdRmlp74Un
	u8yX7JIjX2E11K+d5OdT2n/Oo5+NbDgepNaFowVyu5dlixsoNKSXZ4eWVrUtRvzg
	1qGROtNOOOn1F2RNVl77fxY9CNDAzoyXYgllUj5Y4DPgPx3LPRAS7tZNk9802yqZ
	veIUSdlKfKo3Tde96tBjVrYaWjfZpOEaeWnBN3zAYu+aKxQZJoO6cAsonU5Sf5qn
	Kyqxed5Z1BHW/XTfvcT9PA+DHbYGZpBjFv2/JOT8PZCrbg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1tx2uju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sun, 16 Mar 2025 23:24:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ead629f6c6so83494306d6.2
        for <linux-hardening@vger.kernel.org>; Sun, 16 Mar 2025 16:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742167479; x=1742772279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVYXHxBH6seE+vmi8RgMEu0wKLEvS3tZo1XfgA8OXEw=;
        b=vTWLi/wdneXZcdZDMFJLkJtyO+CiWdG4QoGaQ/F5p83AI3AGUw/MlAGdPpoA8jd5UM
         sT+kEEz8jSQHHog9vUeUd1Z7NM0Wa+q1lKyrtKPHWU527uIAbLQiPV6BumghS8QGWJbB
         az2TolxnflR7K/KQWPxjnZTCjieHpr+P0zcBtOcE28wFpnhq+VgN7T26HsbB0zo861Nm
         BnmTO/HVqf3jWZs5N3vXyRQbVqkNnJ66LgCdCh1XqhiBJwBzIUEPmHzkNbEcUbgXp9+v
         Xo55Fh19najFvQxSQYEip0fF6XH3RptUWEBBOg667dW9fBhIJ3w0LE6rfX4BQ7Np5Wsn
         Yk7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpv+F6zRoCeQk9IO5x9VbL/YHwsKVPulbxwbxFRpFgFH0IHrGTwuAtCT8ELWAZe3i1VN51CfobPNyXShdeaLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fvPdBA3kJptzehyjdAkBtzgC/eNTKviy5i/ZmDARCaEiBJbz
	hE48wwObHR2vBbfE7gu+F7cdi6VYFWkUcJZFVj+5ETowBKf39CnZlsz4iNSxCM/0ZxKIZs4/acr
	HTCkFARiqABcKhN3rCB40WoC+MxVN0wZvKHV6VM1Nq1EOhWvP3asnkuCiGxsSCzluejI=
X-Gm-Gg: ASbGncse0qFww7w3+TtKHDsqP2mR5ijT6DlMPHFQ40iBhYKKGTYI62vH/NTM39D4UGh
	BrCqOXzITdVlL/1pkXNCRuGz4a0PkdIIL6rhRYTt31R5jtfiWDksI81PawZaqt6otHdYcWJ+B62
	BPdClj5XA0f83qq0eOQ14jSf4pPSeVlisKjBOpghEaWuw41yDZi5o7n9XYx1opbzIwQsQukl5jZ
	hket6/fj94zcEzcAd8a7cyRoMNjL7oD/rwXNDU+Yv59B2TiDADRaPj0dQk3m8XQDGO0KFTJAn8U
	fsTQVwDQEDY7NQlOpmsuk5API/7GR049NgMHde2MOhPXAAcpNHhwuc0y5IBH7Vu+xdcr6fgKkkk
	sQ1U=
X-Received: by 2002:a05:6214:20e2:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6eaeaaaa4f6mr174117016d6.32.1742167479489;
        Sun, 16 Mar 2025 16:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDshq/n3e4H7Bf9jNDINDm6F1zU4lmWXf3G5XlWq5YljQ4EqxJd4/CbFMcXmB7cUAootLCaQ==
X-Received: by 2002:a05:6214:20e2:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6eaeaaaa4f6mr174116746d6.32.1742167479107;
        Sun, 16 Mar 2025 16:24:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8516sm1209750e87.31.2025.03.16.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 16:24:37 -0700 (PDT)
Date: Mon, 17 Mar 2025 01:24:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Ivan Belokobylskiy <belokobylskij@gmail.com>
Subject: Re: [PATCH v5] ARM: dts: nexus4: Initial dts
Message-ID: <qcgdpylp4xxyb4zhazbur3mq6sayvftdl7b3ekpkrjdqmjuvdt@rrmu5nolqgan>
References: <20250316-lg-nexus4-mako-v5-1-79feae815a85@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316-lg-nexus4-mako-v5-1-79feae815a85@ixit.cz>
X-Authority-Analysis: v=2.4 cv=W/I4VQWk c=1 sm=1 tr=0 ts=67d75db8 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZTbHHU_yaQzv_LtAvXsA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: CH7wRMsVsRwpX6wt7jxwJSPmBt2MVmRJ
X-Proofpoint-ORIG-GUID: CH7wRMsVsRwpX6wt7jxwJSPmBt2MVmRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503160172

On Sun, Mar 16, 2025 at 11:16:55PM +0100, David Heidelberg via B4 Relay wrote:
> From: Ivan Belokobylskiy <belokobylskij@gmail.com>
> 
> Add initial support for LG Nexus 4 (mako).
> 
> Features currently working: regulators, eMMC, and volume keys.
> 
> Signed-off-by: Ivan Belokobylskiy <belokobylskij@gmail.com>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Changes in v5:
> - Sorted nodes alphabetically.
> - Link to v4: https://lore.kernel.org/r/20250311-lg-nexus4-mako-v4-1-3916c8ec7edb@ixit.cz
> 
> Changes in v4:
> - Sorted regulators and added regulators compatible.
> - Corrected pmic include and references.
> - Moved &rpm outside of / node.
> - Moved and simplify pm8921 keypad.
> - Added chasis-type.
> - Dropped incomplete WiFi node, will be provided in future
>   contributions.
> - Link to v3: https://lore.kernel.org/r/20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz
> 
> Changes in v3:
> - rebased against next-20250307
> - dropped backlight until driver gets converted to DT
> 
> Changes in v2:
> - lge vendor doesn't exist anymore, rename to lg
> - sdcc@ to mmc@ to comply with dt-schema
> ---
>  arch/arm/boot/dts/qcom/Makefile                    |   1 +
>  .../boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts  | 341 +++++++++++++++++++++
>  2 files changed, 342 insertions(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

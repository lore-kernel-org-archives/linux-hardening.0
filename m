Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7373134DB72
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900615; cv=none; b=mZnnnsHPdR9FoHFIVrOLZvPd1gM4zL1e3OGg4RQ1urq5SDEAxkzV7hpkUfDY7JX6agGc6H9VBIUUd6++q+iYqNK2IrP2hnemyq8QKmzx+F22kpZdF6ySmx7QaA6iXkZGdnO4OFjlJa6oQJsH33jLrsS0Co8Byrrlv0WeCjDJtrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900615; c=relaxed/simple;
	bh=3GnuM4Wj29EhJDY4B2tW89H800XohRGeS5DitbRQfJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq1MFb9csgljsTAJ1kXL9f/U8eD7YKxp4mwUjvsEEoWbT2hG49pBzg5AbzPU2H1DPYq2PGdk2rd+3NE63fE9iXQ4JK/pdKs0jdmmEhBwf+Ye5+ot1yElUpyQGxkUwgp949tGOCbH5SrRwRoYC1sOfA/gI8W5L63UQavO4m4AP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QX9eyfRb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GFlra47f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QX9eyfRb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GFlra47f"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PUtF2808226
	for <linux-hardening@vger.kernel.org>; Mon, 8 Jun 2026 06:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u2b9AHBd7MZE3H2QcKXdMJY1
	Vv76xd7PoGCmj92nygs=; b=QX9eyfRbNc5PQT98U326cfPrdhG4wYFr/ivXOjfG
	xmeFlA+KjW/ggrnKj52q8VHbeiJJX/yEkHYjeaTKpGTfjCmLsTOeKkT2Hnxj9V8J
	lezk/zBcJ0ppNr6/D5DsDJ1nQHWa74ZNWrae+nzeVLGfabClTy4bVj/wkr4llsZ8
	OKKV0r+bgkbrAlRD0Uw72qyZRc+qefp9ZaYlnpci0aEk2gvRYTBicA5Y1/O76CEy
	Rkr3bjVB4ikPDNcaiCnmfYfwK6Q1eG94ERUaufZ5o7ydZwwoSLBTB42Vvu0ejj4K
	UYPHGwgdGo+SEvn24CWtWDjgcuo/qvfFLTBqw0mLCTlBJg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w6bhq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 06:36:50 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-96391e58e62so5375381241.0
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jun 2026 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780900609; x=1781505409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2b9AHBd7MZE3H2QcKXdMJY1Vv76xd7PoGCmj92nygs=;
        b=GFlra47fkmV/AYcSXluENCvK0AEJ/l2fgw0VW9akGtYym7m0dUrce+bxifHx98+yvI
         4uHrwCM7Uac/CtyjdP5L04ot0Zh7Y7UL3VgfpcVaKo2mVDERfdmH68hoggV9i4AcU53Z
         yOxx5BzStob/H/Rm0qZhqcfQUMlKOyhGKLl4mnWfB3vgDRSwxBSjOgqp+F7lChMkiljG
         K2I8+QdKhTDkU3eleZS7VeCXI1mwsW/G9E1BC5CRorS0AJEZXcX+cPDIZq88lOgLje5H
         pwTyxQ3Komu6yyrpIQFbdKnfX+QeWE5LohLHX/jq+ocDTgL/izisvaXqJyXuJP3s5jIJ
         zPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900609; x=1781505409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2b9AHBd7MZE3H2QcKXdMJY1Vv76xd7PoGCmj92nygs=;
        b=oe+ULEiJ6tyyPWgEBJsm9pT9G9vgnxgyTwh9UBllEwDtG5UrzXoUDZv5K+SMWRCJaC
         dmn3pSI5cnyAk3jBglZVb+5T4NiCxb6lSxQf6nlkCFCfytL4Age0DOkdZEfq36nePB0o
         RKgYd65jhTiuS0m01dLblRpjDVwTnK/A/QVTNIkHRDOMpowiyfXs9UEPnG5meldSHO3P
         zvJLRku70xbR3fQJUzxpv/X5wd8lSrmBFX62oqWWsO2cBHDleZmHes2QMdk99yKsBNAy
         UwRfa4mfF7/HLuk1JLbvTw3xctIh+vLNxE4lGJSqM69WEzmEOc2EIII9Qayw6CFPPNzq
         K/oQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hOh+GEdAVeA64ykGYCBtepwcDi/ORNxMUG6ZVQTdAIzuQ00unzgzzzZcZ9h+Sdl49zB/9GpRI3KoI71TIIpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fSDCwbjwpF+nTTGGLCzQra8kjLlEaK68YelsL1c2zi3Ojru1
	8O1ZO1kvX6xYyC53MAsiE2sbOnrYu9sUFWzChxjlPkhy85lL4mQAJ3Hq4Q6MywEANOXa6ZXTGZA
	Cc7UzsnmXlCFeFuBHxkS4uOd306pHMWmm9P4b6rY9VK42FkfOElzgudFsZkppVC/EAp9vtks=
X-Gm-Gg: Acq92OGDJRvrYtshDqa6uC4c9yQziBjPfNqcNR3aRr9Zh9qMMsDq5KNIcGxOwdZnK+d
	m0VhxBfaZAxguVS9E04HIYB75O1M/MPMKBW9iyBitUJlqIKA2ZNiRNDoiy2Ah4Z6qrcb7Jeqs5n
	AcFNf+3pqtMqmQWDkAg//QG+qmoK1gT3NG61Iqew1iMjtNgLucxtxub5+OGqZ/f5ZVOacvgo3UL
	G+ughCmQVQMXeXLJQOZVnmoX6cNv2L3PdJCBJ3u8OlJn8UjmztJD7CKSlD5SMexXlbfcw8GfzQG
	2qIsLH86CFN8cBQnaTmeiOX5ruVIDu4GIFF0MldkTBWdmxlo/efZhaN5LodH+vg1mKu8FWQpc5u
	8qYcHuwVYT6AiS+OytKhFZDH7DDD8ku+sijcqVSI9UW79HFZbWi4hZ7Nm6/lYK2lCxKiQKCq6ol
	Uvm0o/5oCbE4Nvlza3Hqu/bH+yATqH/sf0z1t2AGrGPVbVNw==
X-Received: by 2002:a05:6102:40ca:20b0:6cd:b43f:72fd with SMTP id ada2fe7eead31-70039aaf3bemr3147980137.22.1780900609613;
        Sun, 07 Jun 2026 23:36:49 -0700 (PDT)
X-Received: by 2002:a05:6102:40ca:20b0:6cd:b43f:72fd with SMTP id ada2fe7eead31-70039aaf3bemr3147978137.22.1780900609184;
        Sun, 07 Jun 2026 23:36:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8880basm3565026e87.0.2026.06.07.23.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:36:47 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:36:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pm@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] interconnect: qcom: simplify allocation
Message-ID: <czjwf4bstyhgekmilv6tgyzwrk3tkbglbjthzjf63t7uqbg47i@xxztth3jhiy5>
References: <20260608050429.5990-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608050429.5990-1-rosenp@gmail.com>
X-Proofpoint-ORIG-GUID: ulKU_jYP3yBRBdx5UlOAIODJgvJBnm9d
X-Proofpoint-GUID: ulKU_jYP3yBRBdx5UlOAIODJgvJBnm9d
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a266302 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=7l3-gkCRI4JLb9_0IUsA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1OCBTYWx0ZWRfXxtf5n/W0NhcL
 rsdEC8wCKiJDhLtQGvoYCm+l3SBpvfjSAP6U58v9O+/XOJqL87r/14Fo3A5CPc97DOyEx6T69T3
 IPx7LIFqmKI0LHaaKXaSjFU0jALhYS/8x9ckW+feoTd5B/6pg61Y3i6pGq3VSl04nyGQ+lhnC0r
 GQidcQvecxhXvcWtDUdaqBJRppnQJY78SSf+e4TVWFvdZGhls0sh71zZTvBQpLOG3gDlNkAZu4N
 oLvvIaLEAWk2lfhinFfHl/jxhw0j+ifbINKivM7clwGF5eCY5TXzW9QkUqU0XtR5ih9gqA+FXi1
 It08DW3Ym75fwTuv060rwv11F4xjZDmLl269zb7KjSAwwFC+3TWQiFR/2pp3VVGYy3ZCZfdRSlv
 lZ6NXH9VspQ/qP5mGjfUoASvx/mG5eLctVRTGGAWf+DYpOD7pRqX/3uNXqv/P3K94yyEYKLrrxP
 jyVrw7cAEL941mTLHaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080058

On Sun, Jun 07, 2026 at 10:04:29PM -0700, Rosen Penev wrote:
> Use a flexible array member to reduce allocation by 1.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after allocation before any array access,
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 7 ++-----
>  drivers/interconnect/qcom/icc-rpm.h | 2 +-
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

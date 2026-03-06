Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AFD33E376
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831942; cv=none; b=qcTDu/CAwEmHh+rqfnQRNG+ZLcVwb8MUGX1eGrSIFjQv0X0Or4+EHqWQIN08jjgz9t9pJAnCjjFj+bDLxntvuasQxKd5nJWgO/PISRmg9XgIQpG95ij9lLQSWEDumGzVG6Bcxa9cWNi8EtRhal1YrYxVd66DWas12SC/pfcdMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831942; c=relaxed/simple;
	bh=Lo+dXkVoRCQ9V2kc4/EFipIZm0qHajIudIfIYPCgTIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wmlml7STU2sE19xwsMzZ9p5JTCTDPxymqaTAHG3CphSRG3utNxYg3zInbscydWvklMy5OgLvxvHIzS7eAFdCBoI7EvutAuIsfUEieB7bct5+XN/vu9+Rx8tz/45TVAw8JlNLNaOdtwwf443J+7ySHBi1vbByhJMTu15tR2WYZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RQoh0haD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NB2wNOZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RQoh0haD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NB2wNOZP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KWU1M692730
	for <linux-hardening@vger.kernel.org>; Fri, 6 Mar 2026 21:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBrDtPGjQkXXNabe2uu0Xn4yj8xK4G6bLD03csL6H7g=; b=RQoh0haDKfareQKt
	U1bIo1pTITtYkmSDPFqHVxELCtSP/CLjKhCCsYAKDnJO2LrpAx2ZfwPFE4Ktc3uT
	U/kW+qGjW7zyaJDYn9ju/ufWCCMXWabsLBcADMQtzOrjwQLiGT1vFKHL1/ldMkxg
	UpfNV/gEwqmj6NzLy+r+MbvlTcQA8ymXQMeKycezeJjTH9V2pZ5IoQYHEhDx+dPp
	uArT7WhkaBtECC+2gm+8OJ9AlVTwRlCJEGywtTWGVfkbjdxZ/TnpsS8/zmxdqQ1V
	JS/3HJU08zb2mJ+RJI9QyyIsv/sIxaJLFS0T9qYv8hWdWzimkR2Zrm9bVRc5Y4W3
	o/YbVg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr5rd052u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 21:19:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdff07d8f4so9559085eec.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 13:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772831939; x=1773436739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBrDtPGjQkXXNabe2uu0Xn4yj8xK4G6bLD03csL6H7g=;
        b=NB2wNOZPq6ExzQel/tJgmljRmV3uR7qC8KnEy1z4hC9QqM7x0dW63bEapcGlVTNnTx
         1udm26vxO/NavM60PLg0IyLmo/C28BuhKPAasil2nmnkTD5NRiJUepZVkLEAJTCXrdmv
         WhUG7p/BXW5hVPk9toRYOfGGKEBaUvdyhLPO0j6gWVJX5HGaoFaeELloAHWV1NX/JwkM
         oJzIl6lJv9oNuily/P+3OWVFbT/10ROI9/gBXU4tA7G/9SR7dxb8jdfaXu3f9WrteqBB
         vwMMMyWlpEx/HUBQbUYl89rJjiPjQbg7lQl+bjLajdHz1ZAtDVlHUTSW3xJk1CPqFBb7
         uQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831939; x=1773436739;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBrDtPGjQkXXNabe2uu0Xn4yj8xK4G6bLD03csL6H7g=;
        b=M0Gkkf265F7+/EoyYWmnpub2OBAMrWbG8ETrGHTChpAhNycqmgZOeFyMMb+U1ICoXw
         qdKJL+wDsjsKhLQlTBDANCdGBtvZlLRuqONJ/QBkOjfybawU4+v+h1hxP6NZkPAHhw63
         7i6LFuMKITWiPG0l6/WN3C6xWBfDPS5BQ67UIvQHgkN7H74BsjZm7BSBiqNfobCguv1G
         bU9DiFo0x/Jyi1lOUITE0LIYNjDirysIxZpqCc8eEONCVFOHWf3g6MzibiGYO4oop+eB
         wnOtSAVHsx3xxyF9EHQOouUB5/wtOaRT2NGecWQk++wK3ZU50spbFflB8tjUaVd7SND2
         fwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYr2urmfw8MS4gLhiCJR27JftN0O56I31E3Q+kgXtGYqi4L+D5lILCtyBr2W5CvsskFXtZJSkGv0MONI/yK1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRR2+8RAyXfSdJvRHlsEQ5EKg26Q2kvhKeHTlnqmdMhJ/+rCA
	WwL4x5RZvbXT3B2xxANHlewTiMKycOGVTQGMJz4/LR68w/sqfYm4+NVaTBnPGi4UZ3yxYRaoUw4
	0xuBytlh4g2yigAkfOvopWMRgSEG5LuoooxmAYLvi2gP6/7FXLe9GzY1+X8/zmnkgINmVIycglT
	r2MwY=
X-Gm-Gg: ATEYQzyCxQQ8t5F7C2sOb3bLoaUWeODrQu54X1TZUomUqhYUFPeD7u+mXedc4v0Q0en
	cHJsyYQiFLwVJ358xt+wG5W7uMzzDslIp/+ja3gLfKtBEcB1pjZBLQwzNIH5YH4h/3N04bGPIZ4
	EQVP7cK7QWgWIK7I/CmCQnp4wlgW+nu12fCVbyI/YeVn6+LS6p5LuQYkiBYg23EPSdlzR2axP2l
	ah3B7Yz/Tc2o7pD764t+Rj+QP+Uee/BoRRirCC3JvSrOOT6gBAeFlAfo8TdGQXeWPSOqq3lFGuB
	5IYyc38OeeREFYGD+bP1XPFLFy/B/Mui0G8ei0FoQ8FRiMi069Ps168hNRMaNnHMC9BJeTCxpF2
	l9mDivhNUpGM+nU5Mca7Lmk4b5vfjdsVgF2ZD4VexV82hkg47R7DO4M0tIghdd5yl2n4VAqEy0C
	Oo
X-Received: by 2002:a05:7301:1004:b0:2be:fe8:8b0d with SMTP id 5a478bee46e88-2be4e08e222mr1296763eec.22.1772831938781;
        Fri, 06 Mar 2026 13:18:58 -0800 (PST)
X-Received: by 2002:a05:7301:1004:b0:2be:fe8:8b0d with SMTP id 5a478bee46e88-2be4e08e222mr1296751eec.22.1772831938147;
        Fri, 06 Mar 2026 13:18:58 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm2325124eec.17.2026.03.06.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:18:57 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <aZ0tGZnmtGckKJzY@kspp>
References: <aZ0tGZnmtGckKJzY@kspp>
Subject: Re: [PATCH v3][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
Message-Id: <177283193743.1373939.4596850697529267078.b4-ty@oss.qualcomm.com>
Date: Fri, 06 Mar 2026 13:18:57 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: bsnRst4RKbNcU6YPoddPp2JdhHRHUKRh
X-Proofpoint-ORIG-GUID: bsnRst4RKbNcU6YPoddPp2JdhHRHUKRh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5OSBTYWx0ZWRfX2Tgr/92wCnoj
 XIzayqSU1ssmsI/dbMriLMN+dE0KRG4MXwVv1EL94nDC5l9C5Z4oPfv1wn8TXJEzfOGP1pYzt6K
 QxQOhyxcHCjO5qcBR2Sl+8VqmT4/Ib0u6g1MA773dlE2Ps3wOowAblvi0vYuhdWFnftuxFm+UMX
 LJ0OpKgTo9p6WPV30Mb/IrnnYvwFoxjzHssMiIJnUvmMs4j+vyGb738jsJTPbjPfo580uKQ6chl
 6GD9go7W7mqEFD7ktLbLijR5jiSeJW4ayrX3yVacqGpwC3aOEPBmxdkH3pGNm7BRuqpqAcTF5mt
 fdUWWpe7Gg1w825b8CxVrbBXuLA93bA/2DQM9/Dm4nDcr/8aHfNcOSbi9u/FVHFdZbPZDluTA3k
 0ZBXB638BN8uuwb5KGeOePT+m7qGFoZZEY0kx8jIKNYfG2OTkH5/zOi8+bRpre2ahLYMhrnM7kL
 D/tr/xdUuXguai1gUlg==
X-Authority-Analysis: v=2.4 cv=P6U3RyAu c=1 sm=1 tr=0 ts=69ab44c4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bO_SRPZOoruQ8eAkNgkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060199


On Tue, 24 Feb 2026 13:46:17 +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unused structures bss_bias_info and bss_bias, and member
> bss in struct roam_ctrl_cmd.
> 
> After these changes, the size of struct roam_ctrl_cmd, along
> with its member's offsets remain the same, hence the memory layout
> doesn't change:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath6kl: wmi: Avoid -Wflex-array-member-not-at-end warning
      commit: 8e0ab5b9adb7fec3149441621df1cf15325b7215

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA082066DE
	for <linux-hardening@vger.kernel.org>; Fri, 17 Apr 2026 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444156; cv=none; b=FamluYCLAPdoHXnJcUMFQsRlaXG3sqD75PBBGF/BRENVMTwztiih+UP2RpKExoa/YixwoLytN6U8ciIRckJbG9jotM26v0W6shg1QyFdEVR9yZ8ro+wRxMa/hL7usREevQEOxnoa1KoePzVOZ8smazNMXAwDQZ6XMLZsLf4y+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444156; c=relaxed/simple;
	bh=ByaTmtPJ/K+xsN3Lt6JkLMGAoSVGIDe5dtLgioDjxYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGa6CrT3JhPId87sE5xX7ohexn+X0dlwoyZAgdk2oE5T8pRrBKEKneZW3rpkZpDkRl+CWvOO0qz4WFf+11KToJCfMB25ZAZNWuEdHpzN8myRxczqt5fIizC1PY/e3ip8wLVXE12zTKlzi+B1s/EnQxjDV91tB86IXNreVoPSKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVxpG0FH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ahk5uRuD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVxpG0FH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ahk5uRuD"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HG4Bui3929310
	for <linux-hardening@vger.kernel.org>; Fri, 17 Apr 2026 16:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W7Nil3ecXcj
	6h98aqBWWZjhPtJLGkI6jnT03x/3dt5s=; b=OVxpG0FHfDhisAA84Imu2jNoHrk
	ur50hhXxKLhjankYxhqcY165Zwce30QWhedsWqDIswjE2a5EaT3L0SmPlsjHWrCs
	0Mn7TzIQq3feYCKMoY3pGttWOv+NpbkpEsO8085SOvhfHO131iBOSOwWhq7CFZtK
	3E7Hh8rzM1Aobu2hbrK+RrTuONBfvvS7TTeoy3un07o7WzqHXkIWA2NhxsPYl9aM
	Yan3KlWta8QVZxDnNGTzgsNMrJYyNTyAHf+/8aI15RYv/M39M9P/WVW+IKADDRN0
	Fu8EzldaPBWEhzLNtDfB22k/X8h4RbtCAzXaWNSicGyvSknc3epTidtxOJQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkqujg5mp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 17 Apr 2026 16:42:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50da529ff48so21685991cf.3
        for <linux-hardening@vger.kernel.org>; Fri, 17 Apr 2026 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776444152; x=1777048952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7Nil3ecXcj6h98aqBWWZjhPtJLGkI6jnT03x/3dt5s=;
        b=Ahk5uRuDWQKSx6i+tLUGeZVkJQy0e/DJTe1B/uUm2CsL+QkJFqy9kNl8IBHB1YdjwB
         eUSXi5aBCvf5RpCtbSBtzN2xQXA+mhOcTAtIFt8rAvh+mtdNT4WsEEDT3NYV/G1XMhAj
         eEGx4MWoHt3QnTyz/qAuyQA+1cfh82EGsW1HvfS40989D1Rf6N7oTXn9Fg13Xm8GzI2a
         yiAFVheR/jvNDzvqnzPW3or93nnkJ8eoGd5ITQpJiPGg+2eeumL3L04ATHZvUIAwr55s
         lOqlT40ZICUpQHsCkNvydG5LGNmGn0rPHnMFVcNYc2RRWQ9fzf+/9E+p1a6K9skbW7jS
         thoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776444152; x=1777048952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W7Nil3ecXcj6h98aqBWWZjhPtJLGkI6jnT03x/3dt5s=;
        b=dZdmAZd/il1fDGIG18zvaib2JWtSOCO58SMRBvULB/X/qtNFyu3OihZA0up/p1X8I+
         qKyYJ8R83XQ4AkjuS8QSSI/VhQwMxbPAnVVgJHJmc5TC7ObA1SHD1lxFlaSvpi6RzRD2
         NJySQzeTfeIBcHDiNDUWLMfavC1+nL0oHFpOv1NuEi1GZ+pnkMa2FCJB5MTtmMsr6bM4
         OsMrwysOu062GaAGl+Pt8qZ3mAJhL6jpMxyou70Xhnyx9QaYZNpGgejk9fA92H3PMOyV
         CD8/uSY0Rf8BNQnYjl90Y99uaUyGNlps0afxlrpHBFdcMTi+FxSu3rjRPQTKzmp7XsUl
         RglQ==
X-Forwarded-Encrypted: i=1; AFNElJ+T7H5m7x4DrPvA9N8T28a8DY3yy/9/jnTcmzAI/S2RuGDtlHCNcjuftIBeNFtLb9QSTCmSUWITbR3EMw0zWF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3H/YTBRRN8bpfBNQeeqeJ9zJNOjGQKRdO2zHwY1c8RhnnD6d
	qSs64lptmE2rFS+VCEXt3ymMdpNOfDX6Leii94pOrc+lTGRWvmdd8yWw1+1/aRR9LQg+vM7Ks8v
	Zy8XdjgvG5cu+Vj8/FzrRVJiB2mPMss951MsFL3+Vo057WzMrOfsSzSfk8Im0ggVeAJMCfAY=
X-Gm-Gg: AeBDievlew75sUkC8ANRgMc77tKgLJokmySdgsa1/+CvKM/s3hobXSYSp/S1EYkpUSo
	sCRfb9DsGqNvtTCGjnQERa7QCZ3qeqlUe08VtTB0MFYGBN0RI7qnDXqC3TJR3bt4kQ2nVxHKqfi
	oWo0LCe2vgFQCJuX9Is+UQGWorshkypxAxHM0TYL64sfB8LZKTT/H0i7c/xzR1Nw4+/fBBp9PPw
	BJmsx9ix18WCXHitShzhT4+tRGEQdHoSnt8dFJ1CPhVq5lXo3oeBBUB7SK2DZoq/2KI2j6dbW1l
	A3BF24wYl7xTn7Pmjth38q7eYqZE4IniXkkWhWFna7Fj1rqhv5L6/R5aZ8UKWnyYPJGu6iE4eXM
	RVYu0BFSUSLmOOkCRG/TD/61syg58cVguBIq+tl6gbQQXIl6grQ8XXkqIei+C0ejFG2pznRIy
X-Received: by 2002:ac8:7c56:0:b0:50d:9b07:9c2b with SMTP id d75a77b69052e-50e36c8da62mr51569091cf.56.1776444152539;
        Fri, 17 Apr 2026 09:42:32 -0700 (PDT)
X-Received: by 2002:ac8:7c56:0:b0:50d:9b07:9c2b with SMTP id d75a77b69052e-50e36c8da62mr51568571cf.56.1776444152093;
        Fri, 17 Apr 2026 09:42:32 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553e502sm71796466b.61.2026.04.17.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:42:31 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: rosenp@gmail.com
Cc: carl.vanderlip@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
        gustavoars@kernel.org, jeff.hugo@oss.qualcomm.com, kees@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, ogabbay@kernel.org
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
Date: Fri, 17 Apr 2026 18:42:30 +0200
Message-ID: <20260417164230.3158014-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401220643.12802-1-rosenp@gmail.com>
References: <20260401220643.12802-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE2OCBTYWx0ZWRfX6tdEXreyqQ2l
 jYgzBTRsmf1L60HChDnP55mLmZfzBgZdbTMeEAMrV7gsBXJPoak/BADQCcszbQmxEZzTu1uyTBU
 /xwYfqr4tMVlAGBsvAMpnNrjwKbfcqJbDULUOQRLmlZ7iQIjyyZKq1ALxzBhFefNzblPWdqulgY
 TWwkUROKC7FoXX2MFW2RLgzVQrfV4znbYzcgw4JNcNwwLQedua+NteJrR61l5EV9jtRu7yiXpJQ
 tHkV8OMd/wyYRkcwDvMhgTglju3LE/VselKAYIUGQJRrp0LbdfqSNMy6vuHYbFj25wcQbsXgmsh
 531l2FNmtgC/gcfmtU88ByWtJVIDeXvTEdmkp/a7qF2ZcJ7eGDoLXF8kcFa+7IK9pacRKyaEeIh
 OQRGrZK1QwKPIZVIshLMBBUQeJLYIXwu+PSA1UPIkI5tDP0VgemQqtFGobv1O95FhFbUc+HzT/V
 0DwRD5QFLavMnbT5frw==
X-Proofpoint-ORIG-GUID: QPRH4DyaJ2WgccmA-XPzlfN4si9aq-Ec
X-Authority-Analysis: v=2.4 cv=FP0rAeos c=1 sm=1 tr=0 ts=69e262f9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=1lcS69py3Ix-9TsBHUMA:9 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: QPRH4DyaJ2WgccmA-XPzlfN4si9aq-Ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170168

On 4/1/2026 11:06 PM, Rosen Penev wrote:
> Consolidate the two-element allocation into a single allocation using a
> flexible array member. This reduces memory fragmentation and simplifies
> the error path by eliminating the need to check for allocation failure
> between the two allocations.
> 
> Add __counted_by for runtime bounds checking.
>
I've tested this on AI100 and it works fine.

Tested-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Thanks
- Youssef
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---


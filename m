Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBEC459AD2
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981937; cv=none; b=JfZZrOIUx7sgejtfI6L6akTnKX4oUR9NshLbEx4Evb1/EUU3CYGaG8AchP8p3jjWQgkjHbXP4POQWtiqjITAfN9b2I9w6mTQf0upq7cJiO28twcY+OjKe72T+kMdppvQPCfaMdWNgMZjs3/M+dJSEcFnSh65Ws6PJfETYpWy4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981937; c=relaxed/simple;
	bh=HQybE/rREyoJpbWUiRRQYe3TzH2z8xGubH8XzfJ9ZP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCXokZWZ3cbjBa/fST/UrXJ8cF97sqV528Vr/GZwC+tkpx1GOptDkFgESPkLzpMEdw9wUKwgOoR4al1JpLtcBN/5fbaxto/vyNOq6T0eANNKM1yVqKpGE2zEPBGJ+sdedyHOxOmEZoP9Bi1IozSYHzwS3HJAC+9flX3r9WfKJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TevG9fOx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JYzBxcYx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TevG9fOx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JYzBxcYx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L84c9C4135237
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 09:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	51YDh1GOyJ947j4DEGodJFF86zLPqJMFWS1GDsNvero=; b=TevG9fOxvoXuUG2i
	Cxf8oLeoAkajKH56rYbbqXqy2w/n+LJuMyn5M1Rfa72O01Ceq+GGTp/yiB8nowco
	Jke7JIUxSVTCop9pqsHX5Gr5YQnwnGtO0GOBbEnF7pG+k6o7f1qJ/X8WwfxQr19C
	+klaIIgC9PXsygMAKOkuL5ET/xXQQzWMiI0XGMcAqd93t8d8iCFKOjNli4qBW1fF
	x3qzjlWQawvRjy6SZh0DVMHoSRUvYw2OgNnoy/MS04ZWHrhoY8qe1mOodicqXWSd
	iqbpgnzeVl+HjlJaCfK93RkuUmlXJ0YFuCmGQ4A5naxUmZe0xWXqjsiD0IoGn4vL
	kpCQLw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj09eh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 09:12:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936708f129aso452070285a.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789981934; x=1790586734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=51YDh1GOyJ947j4DEGodJFF86zLPqJMFWS1GDsNvero=;
        b=JYzBxcYxr6Elq18ios39SwviynE2t9Uex1WN3OQD3olJbzG4HcHucKrrN4lVQ0VvZy
         AzRex66Mgkm1lzr2iqDn/CKZaNyVCDZTBaMhn6bFy3FE27EjolmNtt0K9w6RO/kzkriT
         jevoKOKVe4JfuU6+l8z0aJvjRbe9kgtqJMtOGZ5gOlLPOA+/wduo2sSimuIuPV5jVJop
         yjChtoUTGMDOjckFpYLVt8SE10lQMP4YUbDdN514lxhbZYQ+dc58dhNY0ki9FBs9mdEC
         GHOFkBNNuS6/ajcER33WUaP/5/EnKJzgvD0wXDmjwmsaspOOpxEyUKYuvuE2st0Bq3Nh
         INbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981934; x=1790586734;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51YDh1GOyJ947j4DEGodJFF86zLPqJMFWS1GDsNvero=;
        b=sdWyudu01eAnxAsni7W9C1VVBmJXSZw9szpcqhU3xJvE7wV+JrviYVedh9rbrqAhNT
         fOVupiSLJjCy29WXCeIPRdaMYDjBO5NXxGaIprHGKzYhA+dPNGEDoAjy47txJNa6ea8U
         aUco3q46M/C/VplMwkljZJotuuaMvfFYYZR3CM2b/KFXtfEEzfjg4VZgLavXh5PmWheG
         7iI1i+1zr/pAYdzcpCjP0bonDfipMKIvofJreJbVD688E8gyXutYsdVFD/8c3x5zDA7G
         uxhsfXCL2USZd3o9B/QrL7wCbewrAEPYtQdYbwPsuU+jWfcF11GVZfb+b6f/eIg35QM0
         odHg==
X-Forwarded-Encrypted: i=1; AKwUvBz11jXi5sVVjoiTf9xc5G3sUWjgitscboaeRigLms4czd4KxBqfxH8gkyk+Z4F2xYRq2BJYQqQeAEx0oMRnVpA=@vger.kernel.org
X-Gm-Message-State: AFuF++lK+z0PtFRURtZxBQ6Ee03aa/XwRMRN0E9enZyNmP3Hp5crojsa
	bn59c4Cv+3ou8uP3LVr5EM64J/OlKPaD6maJTab4lur0666awks+xT7l3kDDt5CQHLWyUSmmfmN
	7s/s7FyK4r0J+m9mxC/ywfifC9omzR0Dfi9EBBczj/f7kb6ZnSBsFzz8shCsrHtQk2v90/bk=
X-Gm-Gg: AYBFou2UcpwW29OTbLLmKR8LISwGqm9xGSFPB6kLZ/6Bt8zE1KmzSGLFsZH1Z+Qv96O
	joGJsbwSQVf5EhTcAvkny319jcXP1cHnPq6KWSa+zfRgehhKPq7vlo3hjp9q3yWjq0/UGG9I/ix
	bf6jBaXcfahpIyVEZqTjKVDSscAuW29bF6Va0UEd527FvajtRJewb+lT1cIHPRwp4q6sKootsk4
	YftulVJrXf6T7vYc5vyRbnvU3joEwFRn0UBb5H5FDW2hrtP5WBt0i21lbtPmxdOb8Xl7DljHQKJ
	0a14AZ8/k0SDDc5qD4qdb+C+9MgsyhQDlDHYDLkaW7WjVntBrDRDP27re3qW4mJgu3adGNJyfby
	MXgJrJl66XTYWux6II4Z2DdQETw==
X-Received: by 2002:a05:620a:4707:b0:938:e23a:2ce9 with SMTP id af79cd13be357-93bf5554097mr856778685a.16.1789981933615;
        Mon, 21 Sep 2026 02:12:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4707:b0:938:e23a:2ce9 with SMTP id af79cd13be357-93bf5554097mr856776785a.16.1789981933272;
        Mon, 21 Sep 2026 02:12:13 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcce144b1sm350038535e9.0.2026.09.21.02.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:12:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Kees Cook <kees+treewide@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gpio: it87: Remove const from labels_table allocation type
Date: Mon, 21 Sep 2026 11:12:10 +0200
Message-ID: <178998192701.38701.14119171190275640686.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917211125.i.966-kees@kernel.org>
References: <20260917211125.i.966-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMSBTYWx0ZWRfX+u1Q/0aqaeZF
 l6yZcD7NtFtCEJ3WKe7DQ1jp5Dmh5oDd3PZiNF6uyfbOyX2nEhcumZXH1ORlakjLhk5sc5Bqts8
 52iSOvoChzdcGiBTmcCw+1noUcu9SzM=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab0f4ee cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tgKY3BxfLQft7ZkSydwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: x9V8WDUsODmQYVYxd3IPgIocWbbBo4Hx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMSBTYWx0ZWRfX7DmoPfkDZNCN
 eO6yo5bskt9bcjZQfcTXSabDVHwrkS3fDIM9D0saunivGfumkkaKuQtigoCX+VNidTIokym1ttP
 toF5Y+7zrNFiW1WjGcLtIXtlLDGC65PauDXoUIunQaMX+bpZshGO4BTwBx7t6WWyxEK++KpfOem
 +l9qwbBn1deHbGKdASXTsU2ItQEDzGLcTFYIuB3KbRbcDQbPuOyGtHqCnYn44okKvr/VVdqHU9f
 NUrpkiC5fgLSqUW2N6L/OAl3EOuuK03vQAeLprRFI5KS8tPjTvU/EpskXQFM1Tb9xHe2pFB/fEe
 +BY19Hg55mmX1MvlpyKA8aorwKBWXZuVYrsQ6V8CFA+pccavdbWENnnPDf31MK5vHgfe56iYlMe
 U18Tu1azV9aWvw7BZs76mwyXUmCWxjQ87QXj1Z1aPQu3eOIpUHeeY5lC2PKaFuMTs+x8PpIz+vS
 uNMQYPkbNFiVaqnCFDw==
X-Proofpoint-ORIG-GUID: x9V8WDUsODmQYVYxd3IPgIocWbbBo4Hx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210131


On Thu, 17 Sep 2026 14:11:26 -0700, Kees Cook wrote:
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> The assigned type is "char **", but the converted allocation type would
> be "const char **", which is const qualified. As there is no general way
> to remove const qualifiers, take the size from the assignment target
> instead. No change in allocation size results.
> 
> [...]

Applied, thanks!

[1/1] gpio: it87: Remove const from labels_table allocation type
      https://git.kernel.org/brgl/c/24715edd98ba62840214a35137ed23e611348797

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

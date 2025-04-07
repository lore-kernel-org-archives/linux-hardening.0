Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B51253335
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031745; cv=none; b=B8KLj8dpks2ToehdBvwZaAXvjphEb9xwlSyZE5DozfF93YgaIhcL2JquAgCxvd6/3TcGKa1d7GwrrzAkV49e+JOtq4jclQuM60k9G/Aj5EgyIeSlFS4b6G4gqs/LXf2Zb1zkZEHVhDnYU1SitIt0HR/V2/pioB0aS7sMwVkvAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031745; c=relaxed/simple;
	bh=OW8gauqUwQraOtuQFrdfsUbe4JWCtBprt5P/iZWxpwA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ar3FdGa1abftbzv6Y5qNZP7eqH0+4sRkvCKH9BcFUyYhHGUFHfvOS6Zzk8c1xVkYTTldPMlIRr1qnPTqiU1Q73SyE56Xq1cXhHSqGMJGXcASZYffA0k4lwgD8BAzG7Dj9v81APkZjxdrPysuYmMCMgGVT+roe+kBfWTLgs2TYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=voMvjcsj; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="voMvjcsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=XylSqMaeGeWXWi2c3Gf5F7w2ZddGoC9yypIcq9xOZYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=voMvjcsjeauRn7Xz4Eq4tXqcVu6EsHj8nYiXdvRvg3FTwGalHdk3Z4RYD0wNGLpQG
	 9smDn2DmBudwQPNoa9x0jPs6XGcMfdlHMAig6pgLmf41CN5WZAZhrj+VK+S3sdTchj
	 6mYR3h+j0YBVV+GfH3i1gTt8TpOwkAJAGc4diA1e1W/3Kw9sMNj8ND9l+T23yiuf1A
	 9X07qGjn+O/xlI2DnyFFghJQIzt+TbyhLl1Y1i1ySwKQeCgDEzLoBieXqf8RxjTllB
	 xkYjaeAZr8MwBP0B31t2KDO1f65vWeaOcDiG84k+qDxM8ke/cI+vUt/ybOxLff50Bg
	 XLZlM9ZGHz5IQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id BD09A20103D7;
	Mon,  7 Apr 2025 13:15:36 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/2] lib/string: Improve performance for both strstarts()
 and str_has_prefix()
Date: Mon, 07 Apr 2025 21:15:03 +0800
Message-Id: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfP82cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNz3czcgvjikqL4gtSiNF1DC+MUC8MUI3NjQ0MloJaCotS0zAqwcdG
 xtbUA0qOH9F4AAAA=
X-Change-ID: 20250407-imp_str_perf-183d81d27311
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 18C5c_QP3sfwN-JJMCgYKri78N0o5OQc
X-Proofpoint-ORIG-GUID: 18C5c_QP3sfwN-JJMCgYKri78N0o5OQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=444 mlxscore=0 phishscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070093
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (2):
      lib/string: Improve strstarts() performance
      lib/string: Improve str_has_prefix() performance

 include/linux/string.h | 31 ++--------------------------
 lib/string.c           | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 29 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250407-imp_str_perf-183d81d27311

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


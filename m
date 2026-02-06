Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1474395D80;
	Fri,  6 Feb 2026 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376500; cv=none; b=hmZpOhWsUkdEX99VZGNG0ydu+w69TDkcBwExNgBgLY7rLAUV5QloHZXVhdpNzvJA4IQy4NNPhR25VU6jacQIHwdNUKZV5nxBmHp/MvNbl4XgWcLNZA8L8O3AO+ZjXOMzVc4w4eB3XCJNB6h7y/LhXnDHn3TK/easCyMwX8XmXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376500; c=relaxed/simple;
	bh=7JpaOg/f3D+7vCPpzVYk7eXwjwNTxWD8zdDSn2v/QYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0TbUv+tNjpWl7+thUlkdrxFoHOeTHwmKONAGS9jbJ7ZAk0TImrMyfspNGFUjv5gE07Lzm1XJJe3aj7wBEVtTwCbilw/Kr0snkroeuzMtnV3g25DspPx0WcI8gii2nM2Y/GXKDxX9+sZqsfFcVg4hxT/HLyFE2ywmVF+Jw2Sfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lezxuHGx; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lezxuHGx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tDEI/GWRahi2pE07GC/9TD0gUS6wvtKdDT3TaBlKGLY=;
	b=lezxuHGxlUbsrVX5E0KPypi3S3tpedzQjpSz0VpySP5gZ2fRyQyVc1KcqNT4guABEZKJ/NQS/
	Fbo+bmAJxyoY6YmAGI9iGq9i1p1o20j3scjByeiMXWjcRPA5Dcl2NiDa3J5ypaFqUd6CVaY4jmr
	MFibONHmoaFlDfxHojq8Vms=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f6rwx5CW1zpSx0;
	Fri,  6 Feb 2026 19:10:41 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 13E0F40538;
	Fri,  6 Feb 2026 19:14:56 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 6 Feb 2026 19:14:55 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <kees@kernel.org>, <andy@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread compilation error
Date: Fri, 6 Feb 2026 19:14:17 +0800
Message-ID: <20260206111417.69177-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aYTH6A2rZQ4Ky-PL@smile.fi.intel.com>
References: <aYTH6A2rZQ4Ky-PL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Thu, 5 Feb 2026 18:40:08 +0200, Andy Shevchenko wrote:
>> For strnlen(), if the compiler detects that the maxlen argument exceeds
>> the valid memory size of the input string object, a compilation error may
>> occur.
>> 
>> For lastest linux-next source, changing ppc_kallsyms_lookup_name() to
>> __always_inline,
>
> So, there is no issue in upstream without the mentioned change, right?

Yes. However, before the commit 889b3c1245de48ed0cac ("compiler: remove
CONFIG_OPTIMIZE_INLINING entirely") is merged, inline will be changed to
__always_inline, and this error will be directly triggered.

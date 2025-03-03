Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D0CA5A;
	Mon,  3 Mar 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012349; cv=none; b=OyHdk5CwLJzaF3xLoscgrBQi5jrtsfLAnCRsgGTiPxfcSSp21TbPUoMdwhOEEEJrvX04AEiGVCqmsrmXsXiSOBPMjC0KJSJwKp5Ls6tICfWspNo8IVsJzr7xbp8jnwzMj7/sUn0wUq4nliafvrKBJse3DjttyLbUhMpriZ8vxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012349; c=relaxed/simple;
	bh=ywkrHKrZ59hArCy+DEUAfdTFeVcMyMLdkIvB8eLdimk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bvvOmY8tjTOzKtiGHhZGKC2VlTocpt0I7rUfdQLjiax7VGuujJ43Dk4XuQGAKocaju9tyQxtk5un6q6svoRR2ji+g348PBECf0XqO8fPP9EC4h42nUV91g6W1Abf2WxrhmmJxhNqIQ61+xcc1Q6CAfzj9/SkOoKrTchTGGP9JJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7Ea9aRr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7Ea9aRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741012347; x=1772548347;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ywkrHKrZ59hArCy+DEUAfdTFeVcMyMLdkIvB8eLdimk=;
  b=n7Ea9aRrV19Nuhy0cQVneqk8YLykcvYNUKBTBjJNqW/HfRjeoRl1P+F7
   i7gKeefPh32GEfpZSAggx2hqPieIC1P1oDdxOx5Nvgc61e45XEwtoG/3I
   9ds2JDHF7qlLG2oo3db+AxjKD5J7bRq4Qd6ezjKWTMz1naXOM6mIoWD4J
   /pR56NHisw5MQg8/vr9cngR7fBOs05hMcSwHQ50KD/qGLiKAJ109t7mF9
   xkZ++14p0g5ezSBYNaL77QLcObugWTecOg5UxZ7kJ34nHWud/i5LaZybK
   1sst8K4w3z1TFy7ntb6zEU3y9ZOmBiqxcKLA8gLnCigQjyYcICaXBcQmD
   Q==;
X-CSE-ConnectionGUID: ldgnCfhqSJmeddp5YIVglA==
X-CSE-MsgGUID: k6It/o4tTMGv+rzqV+vzgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45540626"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="45540626"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 06:32:26 -0800
X-CSE-ConnectionGUID: Up/OuZUtS22+fPDIV8DCoA==
X-CSE-MsgGUID: XWhr57FOTxa1bEWF9YXniw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148926782"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 06:32:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hdegoede@redhat.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250225232126.356274-2-thorsten.blum@linux.dev>
References: <20250225232126.356274-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Replace deprecated strncpy()
 with strscpy()
Message-Id: <174101233787.8641.12386614759241099330.b4-ty@linux.intel.com>
Date: Mon, 03 Mar 2025 16:32:17 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 26 Feb 2025 00:21:27 +0100, Thorsten Blum wrote:

> Since kstrtol() requires a NUL-terminated string as input and strncpy()
> is deprecated for NUL-terminated destination buffers, use strscpy()
> instead.
> 
> Compile-tested only.
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-bioscfg: Replace deprecated strncpy() with strscpy()
      commit: baa18b6ed4200aff869e78f2650123572b6a9ad6

--
 i.


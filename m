Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC782DA77C;
	Fri, 13 Jun 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809679; cv=none; b=mE75AQ3nWT0Fceg+J6ZiHHAlysU+Jj+165mDjjp0kY+ZBwLkCod1FELqPtEq/c0OjWhtMWrYOqMP9YfsPw4XKzZkqm1LZOyrcHuHLEhoG/A58XhX8fHtGTTS1EtdYOv8IP6cGWOxv4+1AOrzk9nexmLeIuLtQ1SSpwpz29NfXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809679; c=relaxed/simple;
	bh=LU8OJNzLx7wW8BhbXNUKCKzFrz3qoYbDjTeoITe1lQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dqTIxzhv6lRoCMfR4hRPodP+B1/8YYKaZdi96W0NOmifskXBTjHlw4MrnwVd8n3jhZ/+iI77CQpePD1aYEP2H7Kv8w7p77XdWmTumrMtuos6dp7S4s7K/kefrtcypjopdXZxNcXXsnyqaXsX1DOuK1JSOma+Npn8m9OYAHPfsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZh+UM0y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZh+UM0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749809678; x=1781345678;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=LU8OJNzLx7wW8BhbXNUKCKzFrz3qoYbDjTeoITe1lQo=;
  b=YZh+UM0yhR75t/LhRhUe1cYsLBz+hiC6Kc/PLz1Zph9YT3JtzV5D9zn0
   ZXT/Bprpi0aDpKP74suWdSTbQiRHuMZuoArGoQkN/AmquvQ6U8U9tbrZB
   a2mnz3rEBbbCAN6rDzPGaC+mf2dm6jo8NMenoIEcd9qju387Zlr9di0Jw
   RsoVPYkPWeG44JU/wS3dEh05Y1s0ClD+gMR1lErV5cvfsxid2uOgjbYYb
   hjJ2Z2C9Cu58MpLh4E2UUFe3FWKvpLycDivEY1Orx3U1oTFoaLtC4HztE
   ExpAu3/0aovUoh95JGOSLvkgCnscq2My9JaDZqvfIPmN4K/Aox0a086ux
   A==;
X-CSE-ConnectionGUID: 9G7AA+edS7CSZU2A1zYt7w==
X-CSE-MsgGUID: P9uaC1ouRPe6B/8Av82orA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69595178"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="69595178"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:14:38 -0700
X-CSE-ConnectionGUID: YMrBMR8eQhaCQbaYzdmuBQ==
X-CSE-MsgGUID: sq44Qaw3Q5qX+Hgt1/gwuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="178690106"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:14:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Hans de Goede <hdegoede@redhat.com>, ibm-acpi-devel@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20250529181831.work.439-kees@kernel.org>
References: <20250529181831.work.439-kees@kernel.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Handle KCOV __init vs
 inline mismatches
Message-Id: <174980967013.26331.3871583437927541253.b4-ty@linux.intel.com>
Date: Fri, 13 Jun 2025 13:14:30 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 29 May 2025 11:18:37 -0700, Kees Cook wrote:

> When KCOV is enabled all functions get instrumented, unless the
> __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions[1], we have
> to handle differences in how GCC's inline optimizations get resolved.
> For thinkpad_acpi routines, this means forcing two functions to be
> inline with __always_inline.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: Handle KCOV __init vs inline mismatches
      commit: 6418a8504187dc7f5b6f9d0649c03e362cb0664b

--
 i.


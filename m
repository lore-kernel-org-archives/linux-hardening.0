Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A754750;
	Tue, 11 Jun 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101790; cv=none; b=JnMYHR+BjZlzceqoiuoFFoJbDy4MeBCQsUW3azRVfqG93jj+loxwV8Guut113YWjjEztefg35n7TfI+/JC5dwdY4xoHxHe1NZ8NmStv+nAv8HB3cqWytDPPkU2ep81XBI5yr5dw18ljz6Bgp6OpTDaNTLBfqxgdJI6ZNaz8Z62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101790; c=relaxed/simple;
	bh=3IQbt4it4ImkcGkHuHt9E1rYBbY3+c+RxiD8Z9kk89A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dhknk6ewaP2gNlPEZF1+5BxllqAQdB1b0kXL7ti2D8pXJeccCBSG4zbfvr6+EGylqTuM3tfUmpECbfs5mlvvEBTNfLBpb32WPIy08aXjECodFf/ga+E85Hvq8GOIahqYx0It1g5uvnf3YfkFVkijFJfmJ3ImRVAPR1Sw1NDRg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAehGxzI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAehGxzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718101789; x=1749637789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3IQbt4it4ImkcGkHuHt9E1rYBbY3+c+RxiD8Z9kk89A=;
  b=CAehGxzIjW8BahYT0u42xj+eNSy6HGlV8uk8zX0/tuxBlHERjv15CVHC
   r6o7zccg/5gs3qsqbh6BrsZ2Ai+/HqRCyNB/vJ1A1mRwzJ25nvDGDCkwE
   QvufOgCCV4d+oTWFCyqrsvcm7iQUGl1v0r1ASok+A1+w2S1CQKLWdjEJ6
   pr9zbKXy7IzWxHi8zUKV6FCcYxDczF75o4sv2NVuCLw8PThGkSaB6p6QR
   RSX+FOTxKar4lYT8XgId8wZL1kBiQHuVEq2CQYHPDRadGQY9yia5ToL0b
   jgJxoX/SP/hA7JKKzc2JFYKDgb/8KRvfhWsDaddMA+SStiPkk3PVhSp2t
   g==;
X-CSE-ConnectionGUID: c61aBkcmRP6p5AJZHkMwmw==
X-CSE-MsgGUID: sQaxj3EYRSypUXQlm4Sg2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14643048"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14643048"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 03:29:48 -0700
X-CSE-ConnectionGUID: qsHIMAWiSo6idkCelO7K9Q==
X-CSE-MsgGUID: +hurPCjwTl+/jLW96WvImA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="43949295"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2024 03:29:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F00B4268; Tue, 11 Jun 2024 13:29:42 +0300 (EEST)
Date: Tue, 11 Jun 2024 13:29:42 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Sean Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, 
	Nadav Amit <nadav.amit@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/uaccess: Fix missed zeroing of ia32 u64 get_user()
 range checking
Message-ID: <ttkmgaktcgw4ryf5ohvydbvi7cpu6xgdc2kregrd2s52ip7d7r@ltgaob6dwl4p>
References: <20240610210213.work.143-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610210213.work.143-kees@kernel.org>

On Mon, Jun 10, 2024 at 02:02:27PM -0700, Kees Cook wrote:
> When reworking the range checking for get_user(), the get_user_8() case
> on 32-bit wasn't zeroing the high register. (The jump to bad_get_user_8
> was accidentally dropped.) Restore the correct error handling
> destination (and rename the jump to using the expected ".L" prefix).

Oh. My bad.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

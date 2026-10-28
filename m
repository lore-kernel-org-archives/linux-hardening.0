Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220663;
	b=RnTKX0qrVEQvmkHhgzZih28qAQMWRTm/+J1MHLJgWhHaiUEf0gunCLHaCw2s2NAoLTy7
	 2518TDwb06B55h63dbpNC3DV+wxLeyohxhzVOvXGw+CeV1Pvw2brE1jvHib7S9F20mkss
	 t016YVtgrTx3uzR/Tch02Wk6JMV5bNjcapwTRiH1DPXYjBUW2e4jmMrrL2y9elpWQGzJA
	 q2Y5OSWJA5ldbOJWX3ZgRQjN8s+Yz71ZfkomWsb5bmtrMrh3s2CEIULQfevExMa2/SZsV
	 UZl1bnXpgke2JD3m5VwV/inoibqjpoB9YfffVKLAj2AgKi1qT83p30XlL2IhtszQk4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220663;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TSWTwMYjtaUgzoJmy0hlvkgF3nPSuQTOgGNjFjHGst8=;
	b=WQ3pyRxSD7jW0knojQFJ5Ewi4YjGgA0kXBh8BqgEIdyBCCreycA4YxYK7xPvOqsa8lna
	 J67/BDzx7N/8RxZ5iF5koIgFhvK4ji+63w2AIXnUKRC39jkFivgAgdAz/sl7oMB/Gw2fi
	 0RgIVMQ1eR6imQeOsk61lZK4UvWfsPAMOuf7PKzJ+9Zv16EUeAnUkCjdQuqso8HvlFMwC
	 +026hBLEJx1HV+zWBCRJ4CtfLMZan19/+Lw4+pWILPG34oSXlbE6MCdkCl++oWYLXirGx
	 cEDzue0ajyD58XK9iS0AmnHDKLgmbNPlrkIQH+Iihuco89JSf67HUmS25VdR6tGSHFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hvBJIToO;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B6606A31F;
	Wed, 28 Oct 2026 20:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 018B6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hvBJIToO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793220661; x=1824756661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TSWTwMYjtaUgzoJmy0hlvkgF3nPSuQTOgGNjFjHGst8=;
  b=hvBJIToOh14/KnN8ij7Ib4yNz8rZRRgsygZgGBGVGas16cDhdMcBAIt+
   mkdRpV7bYQwpPhzuEJAdRiT1iDcSCHxfqCeioAxWnmM8TyZMejPG7MWqs
   8kVEDnYLnaJ7GPFuI5F5roCcidhydTSy/QLyM7YzDH1NlfUNA9CFxPOvg
   spYRlnmpyAXLXZPAcvX41axr28BIJnZYEK3fawrSDVmMjv5A1JvtVUW0e
   dEgMssA+Vbh85UhEt8YVB0KrLJUEVEf8GiQnVt5FL6fCRTWXUXz/LH8XA
   Ut+NEw8ggTKAzRVQK/GnTVEjNNE3/eVpbA7B2/iYxEKGkcZ01AJBkoVXa
   w==;
X-CSE-ConnectionGUID: e4tZDtuFQQ2iRxOPBZ53tw==
X-CSE-MsgGUID: s1HWQ5PYSF2bcKqqm9Y31A==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1971265"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1971265"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 13:51:00 -0700
X-CSE-ConnectionGUID: CfVnjuYjSD+ILdf6xGMCow==
X-CSE-MsgGUID: 07F29Qw8Trim9omE97SzGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4860617"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 13:51:00 -0700
Message-ID: <3d982c1c-4c97-4dbc-958a-4e71131c0020@intel.com>
Date: Wed, 28 Oct 2026 13:50:59 -0700
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/entry/32: Harden return-to-user
To: s1nkhole <dedemorow@gmail.com>
Cc: x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ac147f25-a2d3-46b9-89c5-44a1c0e4f038@intel.com>
 <20261028192139.32606-1-dedemorow@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20261028192139.32606-1-dedemorow@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 12:21, s1nkhole wrote:
> If you have a moment: this is my first work on arch/x86, and I would like
> to contribute something that is actually useful. Is there a small task
> in x86/entry or in kernel hardening that you would suggest as a better
> starting point, or a place where help with testing or review would be
> welcome? I can build and run kernels under QEMU.

It's not small, but kernel shadow stacks are an _incredibly_ powerful
hardening tool. You can buy a system off the shelf that sanely supports
them (including FRED), but the kernel doesn't support them yet.

My current work in progress is here:

> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=kss-2026-10-23

Another set of eyes on that would be nice. Although I do think I'm going
to abandon tacking the shadow stack on to the thread_union for now. So I
don't suggest looking at it too deeply until I get another version out
the door.

One thing you could do today is go into the list in here:

> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/commit/?h=kss-2026-10-21&id=4dab5fe58904ee07b3622f25bbe3c1b7ff820bf5

and pick a feature or two and figure out if they need fixing for shadow
stacks or not, and if so what a fix might look like.

Or another set of eyes on this:

> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=taskfun-2026-10-26

It's ready to post but I'm just waiting for the merge window to close.

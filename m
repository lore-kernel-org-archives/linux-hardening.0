Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799C1EB9E1;
	Mon,  9 Jun 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499972; cv=none; b=eOTCPsdPvfYsTsXufiypuagVC0kQkWym2dMeo2peZ1y7skgyeAF1mb1UakPGEi8rqYoDq+CWAqE2jSkCSZ2L/BHXjcltHtRtYQ0F7WHYe8TMMzDGXQUHXEoTWHHg5NT/LWw01Y/T+0f5Kf/sjyq2hRbHPAIciYlakDnnXsB5epQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499972; c=relaxed/simple;
	bh=LJ/uZDXg4Dz+jNqe8xKGNosRt70el7DilOa/Q+s44xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfZAjbsPp8HUExtHvcs05G0lrrODVzkchdfumreyYile9gfqsh2EaiS2jAAbIUoEzwj86AvlkS10yobVDNac1NX+g9MNMl/eYOB4O1bs+cckZDBvBAsPcMlVVlo7dkExleqa7NpOKbKTB7EJvQBckHbeyfAQnoIMfxyjkiZUGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCgo9+6R; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCgo9+6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749499972; x=1781035972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJ/uZDXg4Dz+jNqe8xKGNosRt70el7DilOa/Q+s44xQ=;
  b=SCgo9+6RTQAEQGbo1p7wLW9MaFAD0iC0EMpdrAQWEeL6wLttW5BcMtUE
   djC2Q9hhoI9xETJxGDkbFzZLNslqYkajKqbh2tal22WsGUX2pVVJZopmi
   jXDHeqwbTlgokzyb7dIVd5Rc/32sAr0lh1+r2+i9tUNDplHcmLnyal38z
   Dhg/vAZc3NUAXVlO1Av000W1BBKstmgb5C6jr4rU9+8ZYsxM4I1BPvDIb
   sse/gbrYXXhrcVOU5o/qmr0IUAKiJXsIzdeDdGQet/QsfMkSf58Q3vOe+
   XxgPJrbUotMvzw9AouaL3Ud3S32lmcZwz5Xze8lVqG/ir3hL7A8NV/xMc
   Q==;
X-CSE-ConnectionGUID: 9ZAOTH3/TJqW0nN8XK+gkg==
X-CSE-MsgGUID: /G/ORU5TQhaDTaEfodPc9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51677175"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51677175"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:12:50 -0700
X-CSE-ConnectionGUID: JgUShucbQ3mQBwHf/RSvig==
X-CSE-MsgGUID: MCcgyiSGT0aLouJwJOiQ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="147188410"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:12:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uOirG-000000059XK-27RQ;
	Mon, 09 Jun 2025 23:12:38 +0300
Date: Mon, 9 Jun 2025 23:12:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] slab: Decouple slab_debug and no_hash_pointers
Message-ID: <aEdANsGsQHqVQ9Wy@smile.fi.intel.com>
References: <20250415170232.it.467-kees@kernel.org>
 <Z_-dPcdiGW0fo8Ji@pathway.suse.cz>
 <202506051314.D6EDFA91D@keescook>
 <aEbyHeG8qh8GChTh@pathway.suse.cz>
 <202506090823.33ED63C@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202506090823.33ED63C@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 09, 2025 at 08:24:47AM -0700, Kees Cook wrote:
> On Mon, Jun 09, 2025 at 04:39:25PM +0200, Petr Mladek wrote:

...

> As long as it's in -next and scheduled to land, I'm happy. I'd always
> like it earlier, but the less workflow disruption the better! :)

Hmm... The __diag patch series were in Linux Next for a few weeks and did not
land in v6.16-rc1. Just saying that there is always chance to go into cracks.

-- 
With Best Regards,
Andy Shevchenko



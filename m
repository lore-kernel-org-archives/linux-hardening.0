Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DB2222A9;
	Sat,  3 Oct 2026 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790993044; cv=none; b=ZqdvK6SYQUKnmOa07XWRGwJY1vsTCscnhedVJKulsZhfuzRD2Racm5cRAqP0VUqr8ptaw+NuAXfUswZNQ7KHZ+zbt3F1Zxo1xo0uONKRgBg/p8Y3su/CEU09FU7cE7kYK4DWbAKi8pOSisj6J0sH1qjB1Hu4nppPINKNU+sStKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790993044; c=relaxed/simple;
	bh=v7QDdZVdCAhWypiGQR4nLMB2kbizBhlhlNcDflDVCUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttbO7v6aOjOWOv5fvE5IIOBNdQn2VeCgi3/qlPxTcvBqew118iE40/QsgAiL/QJqmtjJrv9uRyp3dT1Wjv2Bg+yi5EBOxJuJ0IHfK0J03vwDSrHaDc5UtbQH+occCl1UVzu8FqN7u3MdjrEYCRgu0BQW/J3J2Zv9LV7UtbpLpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl0Bqyky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl0Bqyky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560E31F000FF;
	Sat,  3 Oct 2026 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790993043;
	bh=QFwjWSfS4UzWfviIUGkyHadIu4D0jlZhwWB3B2Ln5RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bl0BqykyEA9wf/Pkq6WwEgj5A+Ohu24fTeS172pL+eZNWL4Krn0LCNRURDW1vt0sE
	 zsd/jRbRy6L0R0NZ5RrtPkfNid9huzje1HMX+rryizg1s1i6pGyfbEMJN0C/cEjO3s
	 ccQHj6IiIpzc4S4PjVnyjSAi3Vd+Ng7Sbm0rSk/May+7IeDncckxxHKiOKSgco8V6H
	 F135UcgKhHST8e1UmKU0U+yV6sWc3LXbzBt+KPALC4zoUHAS0592eoIhM5FnZFvrZR
	 0SVaAVCIIxXGzlu/XhTezZbabYZGO7jkal/PhO42gJWIpdqy0y9oFu1Fr/HBQ8mtXG
	 h2AClc4kEt8kg==
Date: Fri, 2 Oct 2026 19:04:03 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bill Wendling <morbo@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 08/11] seq_buf: Add seq_buf_init_append()
Message-ID: <20261003015946.554434-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
 <20260930235247.157921-8-kees@kernel.org>
 <ar9bRGk_TpWq9-zl@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar9bRGk_TpWq9-zl@ashevche-desk.local>

On Fri, Oct 02, 2026 at 10:20:36AM +0300, Andy Shevchenko wrote:
> Hmm... And if this becomes a size? Shouldn't we set the overflow immediately
> if the existing buffer contains a garbage or has non-NUL-terminated content?

Yes, good point. For v4 I'll have a buffer with no NUL within its size
start out overflowed.

-Kees

-- 
Kees Cook

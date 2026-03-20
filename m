Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B30351C05;
	Fri, 20 Mar 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035283; cv=none; b=J8RmrU25Cmz57gxA/efgwINo+3iR1TX8imMOOKyRXDiDCef+YnQhRKsTbf939sA5u//oQuZvhQnl+lUDG+sUmhgF9/9SBZeBaeReZI7TabphHktkNE5LFZpRyh3EmxUilqDivvjCfNTO8oxoBBuS+zv3YNQXI81SpJiZLek0wOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035283; c=relaxed/simple;
	bh=VKd3vG3YD2f8nfFDLl+85SG+6H9rK8JOoLwsfodexWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm0Bj3oO6Ydcbc6h97z5RYtQ52WDD83/m5O/z0vaAFDGEfwiJeGhiz9dRdLfes4ibda0LGNtAiKEvzjZ5P8x+CK5lYvtXA4QBkb1xhyfrSBudhyG8Pl6efKYaANPgdtAoQjRd+uz7uwcTEE2bUCqxE1O0tnKnNUCQV5Z930z36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMiCDOy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMiCDOy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7323C2BCC6;
	Fri, 20 Mar 2026 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035282;
	bh=VKd3vG3YD2f8nfFDLl+85SG+6H9rK8JOoLwsfodexWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMiCDOy7wu2r/40o9YD7Amf0FefcK+YJxOYTs2CvA+HbenqirVEoyn5OvlwvXdX4a
	 36jiq0PkBvuWdrTeHzzX1jwA24tPhhGNSOPn5qED5EWcYbMjt3QmBFbYhdfXoL6iW6
	 o92FFvuUTJw2S2HEUxQs2SUeFyVPipxXAfLxVYlT7xux2IxW2OLBEi1c1zYEkhU3+p
	 Bg8XnttvkC03c8U+GWq+w7N57BOdvJqTZmHkx7iZ18eDtgSvIo+EtA0O3VCChe+Jkh
	 S9+PgSBfEvMaP5faU8znsEQN//20vS287Tuvi1b8UNuFSO07TRFhjPKtvo2nd2MDNo
	 Pvkv+mtawu5BQ==
Date: Fri, 20 Mar 2026 12:34:42 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Josh Law <objecting@objecting.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <202603201230.74BBFFABAD@keescook>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
 <202603201216.3CD33C4@keescook>
 <ab2fNTeawayVvjZv@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2fNTeawayVvjZv@ashevche-desk.local>

On Fri, Mar 20, 2026 at 09:25:41PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 20, 2026 at 12:17:54PM -0700, Kees Cook wrote:
> > On Mon, Mar 16, 2026 at 06:01:58PM +0100, Andy Shevchenko wrote:
> > > strlcpy() and strlcat() are confusing APIs and the former one already gone
> > > from the kernel. In preparation to kill strlcat() replace it with the better
> > > alternative.
> > 
> > Yes please. There are a few places I looked at in the past that might
> > benefit from being changed to seq_buf or similar (where snprintf doesn't
> > cut it), but otherwise the removal of strlcat should be straight forward
> > and would be well appreciated. :)
> 
> Thank you for confirming, this is basically the message to Josh to find
> users and start converting them and kill strlcat() eventually. Josh, as
> you see it will be well appreciated!

As an example of a seq_buf user, see block/partitions/core.c:

static struct parsed_partitions *check_partition(struct gendisk *hd)
{
	...
        state->pp_buf = (char *)__get_free_page(GFP_KERNEL);
	...
        state->pp_buf[0] = '\0';
	...
        snprintf(state->pp_buf, PAGE_SIZE, " %s:", state->name);
	...
        while (!res && check_part[i]) {
		...
                res = check_part[i++](state);
...

All the partition handlers then use strlcat to append more details,
and it's totally unbounded. The correct thing would be to build a
seq_buf to attach to state instead of the pp_buf, and the handlers would
use seq_buf functions to append their info, etc etc.

-Kees

-- 
Kees Cook

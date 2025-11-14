Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1F25CC63;
	Fri, 14 Nov 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135272; cv=none; b=ND1ApAmi2mPEEEEfupyiXQpAFUXbpeI1mxJZDS6dAlBVHLwZ7GFcGdgFQEZh3/m5dDkL6OciH0xw1+40iP/cyIca/B1zH320qAIB9oTWpqc7XzZx8qO3hd9OLVfq5PWxaJT4ZG1HyDWdLVKyoFlYCp01F52Vy9DeEV5gyFedrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135272; c=relaxed/simple;
	bh=KDbByiGZSmqnZP69FNrRKl2VTaaojv1bgAQi1GcFQpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMD6DbD/DQfLz53zhg3SoMX/4Nf9Xu0rhGpaJacAKhS4zdxVCFBBWIdgTxnw3FnV1qSiWar+7xkk9LJ4fchsUwOZZeRBP/ugEGayQwbszOdsWMuJ/xBudn9pR2QM5mR75pBUJHhmvA0eVFyeF9fq1ee7mLBIPjKuxHl7tQzFr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 6A17A140412;
	Fri, 14 Nov 2025 15:47:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 6404C20029;
	Fri, 14 Nov 2025 15:47:46 +0000 (UTC)
Date: Fri, 14 Nov 2025 10:48:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114104804.24b58b0f@gandalf.local.home>
In-Reply-To: <20251114150209.27354ddd@pumpkin>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
	<20251114084346.6469edc0@gandalf.local.home>
	<20251114085332.396aff85@gandalf.local.home>
	<20251114150209.27354ddd@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tespnoxeaf8pb8kqys9eg8rxnycfdq3s
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6404C20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19wYKTOkzIRNYX0CGq7GS61NhjDrDEcYfk=
X-HE-Tag: 1763135266-813555
X-HE-Meta: U2FsdGVkX1/I5payVIFur9IdFZmupCOlpFZPqI2ixTgCtTJsHSmFsbGUuU7yUg8fdw0pOumYE2X9tkYS3r7Nj9YeneNYpX868+TYhu3rYbByg/qL/UiW6uvYcajoj3SO59WiZPZ93Pz7bVG0N3xIXYrxUUjrvnvFQYBE1QNlxswU7Z9eBs2N65wsbfnHRu9/apLGzfAAu7ekDXmE8PqYsItmGNuufL0uXo4XGcjMUB+iWuW4iXe/cey7c+FE2/PYpGW+tUrV1v1eWmzyhyHYNqnAKe5UcZv75OULB/tiPJ2PaMDjZavVkV5JeoJLUBAknSoBLfKTLYQSb6VKDOJUBpbow3+BsFEN

On Fri, 14 Nov 2025 15:02:09 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> > +/* Make the cache fit in a 4K page */
> > +#define UNWIND_MAX_ENTRIES					\
> > +	((SZ_4K - offset_of(struct unwind_cache, entries)) / sizeof(long))
> > +
> >  struct unwind_cache {
> >  	unsigned long		unwind_completed;
> >  	unsigned int		nr_entries;
> > -	unsigned long		entries[];
> > +	unsigned long		entries[UNWIND_MAX_ENTRIES];  
> 
> That won't compile - I tried it.
> 
> You could add __aligned(4096) to force the structure to be padded to 4k,
> and then define UNWIND_MAX_ENTRIES in terms of the structure size.

I rather not do more tricks than what a comment would solve.

-- Steve

Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19D32572D;
	Fri, 14 Nov 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135379; cv=none; b=n8O5HITs4LLY1/onjqpbP2XSN/CZuEgtXeLooxuoDAik50AV4Zu31HoTXHiygimOflGrmHOvxFQo2m4rd4dreeowjPYSII+7CLwj+h3PKUVWXN6K2yNQrWDafm8WD/DRRynDb+Wc1GAjp92NKYH2CAREytCRLdGTigJtG2AsCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135379; c=relaxed/simple;
	bh=oRnvW56+d0JQKK23m2G5B9y+/BodTl65wQX95ahIOCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D83vK7ZJV4dE5pP65ECbeNac1E4UZuIg9WmL+gwflei0APf0Hbvi1SCTlr6oEfK/bK8ENHuj1LkCC2aFwmWw7Rwjps0HFK1OGSAAH3vYl44TNVcYkMf5gHJr/O2bxeZWmRMWZSOhmjDSgc8c2AOAaWEfaJ5yQeYqLTZZLIZUbQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 0A4391603C8;
	Fri, 14 Nov 2025 15:49:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0C0FB20027;
	Fri, 14 Nov 2025 15:49:33 +0000 (UTC)
Date: Fri, 14 Nov 2025 10:49:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114104952.045805af@gandalf.local.home>
In-Reply-To: <20251114095644.116a767d@gandalf.local.home>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
	<20251114084346.6469edc0@gandalf.local.home>
	<20251114143104.0d1aead3@pumpkin>
	<20251114095644.116a767d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0C0FB20027
X-Stat-Signature: jsf9ntkq1o9ba47o4unu4z5drq1bopzs
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/cxjDn4Vv7s3rFJr7hal0bIzO0trktHk=
X-HE-Tag: 1763135373-170811
X-HE-Meta: U2FsdGVkX1/R52Afbnazr7mfJ+wOUHDc/o4eKw5mn81ev+t1BKJ28efVUHd22Imvlwzd0YH1UKIBFXJIaTtkukoVYNgf98K/gPWP0kXBaeha5RHdlcPLJ2sILGsn8k38YUKgOPu97TA/vpQ6FesjhA6QJw7f1xHnNMPird34HhzGM7/Gk+88OiYHrk/kYfKwDmaFzDFpX/2Hco9b+9ce75Z0ixkdDkXTOdWPqiZtKIX4SAU3ZQY2m7B8pESqTWHfi1bvdffx5C8c/LfW4B6DeeMCWm83dW/0fkNMycYOOo3kBIoUWD0QzwTks7J+ibn+srn+2ZRNX6P2CExbl3Xv7JunTHSaoUJ+pxC8/CQvUlBGYZkUCupivyKHWIBE19Z6

On Fri, 14 Nov 2025 09:56:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> >   
> > >  	unsigned int		nr_entries;
> > > -	unsigned long		entries[];
> > > +	unsigned long		entries[]; /* Fixed size, not bound by nr_entries */
> > >  };    
> > 
> > Perhaps it should be:
> > 	unsigned long entries[ /* MAX_UNWIND_ENTRIES */ ];  
> 
> Whatever would keep the coccinelle folks from sending more patches.

Thorsten,

Which comment would you feel is more obvious that entries is not bound by
nr_entries and prevent this patch from being sent again?

-- Steve

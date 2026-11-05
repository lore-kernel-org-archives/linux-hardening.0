Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890864;
	b=e5Grbhq8BLDQj561krfI1EJ+0wBefiwjJtldhtbRMnW6ITy+qPB48sV5inEPVwWBmwBa
	 f6fLJ67M7ZQGBlMccTdfOy171ER4rzYO++rTMEE6UKlb6YkyoB93V5JfPpcudyFivm29w
	 LiK2FDHkZrWPDPEo83ufxay/G0Y2CcY59HJX4Ig71z2YRwDnVDUPcHf3u617nIkFKDFv0
	 O95HnLbHepw7oE570lvbWmhaGvXNpN8Xmw1Hxh+A7CYO4AgQZ7guXKNZTRwgcXmaiEDuZ
	 mYBZygSSr7WtVjpiWJSOk2qKgiBk+bj2lUk09P5vLL3vB/u3nZ62ipYlur7XuncAAXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890864;
	h=Received:DKIM-Signature:Date:From:List-Id:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YikqpgDG8M78cXIlVxcKjaFkFjk+ChsNabRfS6Q9WEI=;
	b=wpw6ruKXnHYjJgZQNOFkhER5MArRyzExmnoP1l4GOtLWhofyWpFs5jGOaJ2WHXhB/I5W
	 PHDs0GWEhIz6LZDFthTT8y6zjFbUsGdh+ZAnAJrekKT0T7nRQzUWmTvqv+NENNn0x1uXP
	 StPB5NAXFIquijZOwFs0x7SbW3Br6xvMLHt6zglqoreXhnpqIfFFVr+VBrosuOnJn6or/
	 DOnLivvQ/cyy/B+kklZHjAbSDfo+Qy7VUrDEf9wJOtnXPNLx+Djrhf+eTmURhTzf/Euw7
	 nnRTkDIcQrM127AMo4MpMhPE+gjtVGmjr4uqbcHrs+sd2tzLZqwwjDrW0qJZMbb1z4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hZBF9q6/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 38D46606A33E;
	Thu,  5 Nov 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZBF9q6/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 722A11F000C1;
	Thu,  5 Nov 2026 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890863;
	bh=YikqpgDG8M78cXIlVxcKjaFkFjk+ChsNabRfS6Q9WEI=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To;
	b=hZBF9q6/VKSxXP5docH2Gj5fq9m37zdZV7Col4OBl5xGxhd0vJHg/W//wBvX4OxoQ
	 vFzJSUrZ0K6ehrM8xJuFmqbzqSvk4sZQpEk9m+h6dvAfXJuLLf2OdmCRjLxA47tVB4
	 +XZak2u0kk3O9e5MHsAAFeNrURL44Q7RSPYX/D07JYHxTSmLgG/Q0fui+C+rwVv5YW
	 JgJytYfRHBQwemqWR6Sq3oyQ0wip0u9td+EDJmYtkoy9UfXy71ypjOWrK+jLHpY7/h
	 ZEVXG8oIYdPhjuPAAoe8CoFgGe8fkUbgeVXQs77VXKNRx1WebooUyqLNkdUMsUVtzn
	 Cbo8o2w1QEyjg==
Date: Thu, 5 Nov 2026 16:00:59 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <3lj2ivlwz6wpf66u3ifg5lxlmqbe5gulcr56rd7zxcgrhx2pj6@dxdqaxsp5hvu>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auyOkL1Vb1iKicS9@devuan>

On Thu, Nov 05, 2026 at 03:16:45PM +0100, Alejandro Colomar wrote:
> Hi Bart,
> 
> > Date: 2026-11-05 15:01:22+0100
> > From: Bartosz Golaszewski <brgl@kernel.org>
> >
> [...]
> > 
> > I have no idea what causes it but I'm getting so many patches lately
> > that are subsequent iterations of a series sent with In-Reply-To: header
> > pointing to a previous thread.
> 
> I don't know what others do, but in my case it's a conscious manual
> action.  I use --in-reply-to in git-format-patch(1) to make all
> revisions of patch sets be descendants of the cover letter of v1.
> 
> We do this in the Linux man-pages, as it helps me keep track of all
> revisions of a patch set easily in mutt(1), without having to follow
> links or use more-complex tools like b4(1).
> 
> > Don't do this. Each new iteration must be a separate thread. Please use
> > b4 to manage patch series.
> 
> I won't use b4(1); I like bare git-send-email(1) and git-format-patch(1).
> But yeah, I can send them as separate threads, if that's the preference
> here.
> 

Yes. It's also the preference mentioned in the kernel documentation for
multi-patch series.

> Out of curiosity, what's the benefit of having separate threads?
> (Or the converse question: what's the main problem of using a single
>  thread?)

I may mark a thread in mutt as "done" for whatever reason and then all I
see is a reply under something I've already processed so I may as well
skip it. On the other hand: a new thread gets my full attention.

Such sub-threads also can confuse tools like b4 that maintainer use to
queue patches.

> They're morally a continuation of the previous threads, which is why it
> makes sense to me to have them as subthreads.
> 

That's what change-id is for in b4 tracking. That's also what the
changelog should contain: links to previous versions. All this is
already handled automatically by b4 which really is superior to manual
git send-email in every regard.

Thanks,
Bartosz

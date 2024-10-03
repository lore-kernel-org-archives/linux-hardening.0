Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FA17C224;
	Thu,  3 Oct 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968375; cv=none; b=PMm026BDVbdhGOUIUkaCbfr0mbepepBHHaxQDPYlKxhHVy92TIN3pl9v3J13OQnGRJLZ/iEI6q4igoaLqRKA8chJaf50xRSofZNuRv4VG5nTCHtoXfkKbG6Sxturu/ZlRnq9OXo2kufYLTijHg/jMB/gM7wFi19uN82A9Zjph4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968375; c=relaxed/simple;
	bh=1y64kIcjvUL7+gyD4r5qRgnVKgoWbbOX1O/syA7xGuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsxwyp6hLKw7b5HIL0h/qzAxpJyA26BJE2zFLnzVJYf/0494/DQcuJuSaRmi8SL8tnhZCon05EgFUH4cP5QWn8JYIj0mXoB97l33r7FB6h6pck6gHRyIleLoyHc3US8SUDeoAMF7M2OQ59MZU8E+8whaXKagnIAH7T/pwgYsPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CA5C4CEC5;
	Thu,  3 Oct 2024 15:12:53 +0000 (UTC)
Date: Thu, 3 Oct 2024 11:13:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: linux@treblig.org, kees@kernel.org, andy@kernel.org,
 akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
 senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printf: Remove unused 'bprintf'
Message-ID: <20241003111346.0654f1ac@gandalf.local.home>
In-Reply-To: <Zv5SLrKeQIpWnhsS@pathway.suse.cz>
References: <20241002173147.210107-1-linux@treblig.org>
	<Zv5SLrKeQIpWnhsS@pathway.suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 10:13:34 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2024-10-02 18:31:47, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > bprintf() is unused. Remove it. It was added in the commit 4370aa4aa753
> > ("vsprintf: add binary printf") but as far as I can see was never used,
> > unlike the other two functions in that patch.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>  
> 
> Looks good to me:
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
> 
> I assume that Sven is going to take it via the ftrace tree as he

               Steven ;-)

> suggested at https://lore.kernel.org/r/20241002104807.42b4b64e@gandalf.local.home

Yeah, since I'm basically the only user of it, it's best it goes through my
testing.

Thanks,

-- Steve


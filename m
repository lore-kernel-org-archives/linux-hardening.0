Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D413635E;
	Wed, 11 Jun 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652807; cv=none; b=TXd9wgt1hoBWVRkOpE349vZvHSrpAOEywu2NAhqvuYlDjnnxvE8YXGzDZRe1ad1qt/7+2ABA+uZ8AgpJPqR8gqDYWHCd95RY2aOK+/2d6gHvPyRWLlxmb+J4/+dkhnezaFfldjHuRm68jm4zZaU0pYNPy9y4LsQPnpbhxXeRSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652807; c=relaxed/simple;
	bh=0ohGz/4GuhWVzFJeeiQQWGKcA1Cl68f8/k3g+lzPV9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtH22Eh9kZEF+VbuwUg3LyxafVpctNaoYRto90PrmiV9It9ezCqi/fyASOnVY4Tn0FCiIgAbkv5KrCPilQjtvIK1rQEyiEC8TlxtV54//ZKtKPrjabu94mgBR6K84nij5slhAlQjJw7c1TJaan+gbTpOyPSyGj+1dQaDaqegOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzqg/HGH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LmHdTqZ6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzqg/HGH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LmHdTqZ6"
Date: Wed, 11 Jun 2025 16:40:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749652803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWM46jWKP7aNFgqvaKUjJ8B+43hx0DMeI0J+u6bVndA=;
	b=mzqg/HGH9SEt5YtmM7Es2WzqVhSUUXiVxmwtTsxcs+GvSsoAcGpJ8Xtud/0jqJMVYHzBaf
	yeggLFhdRyUT39B5lTaat1iItoMM4ePA6D03ETn27/JqdPy3cldZCSP5jw8ILtakqQw96n
	n8eiHiInjFbUhZgBqxpngeiJytm6ghl0fMfqD7lPVsRYObqXDZu/PXQtgceWG40aol5n8x
	y/wJ3CFz8ZJm1trpfuTcGObz5P2kh9cRqiJnJ+B5khJnzjN5hqf5Q/6dgAlRzWFzkSNxt6
	GIDWE5L/X17tyvmQNJacOqV7KALkW7fn2uo9tmwTKNn5xTwjLhlQm+7hGqg6ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749652803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWM46jWKP7aNFgqvaKUjJ8B+43hx0DMeI0J+u6bVndA=;
	b=LmHdTqZ61yBtpSHERUnXrM0qSX5pOfzhECOqh8QBSaQVHvwis9vwfcHKtAnAMECN1dEr7y
	StLfceepIs5iswAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	John Ogness <jogness@linutronix.de>, David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] printk: ringbuffer: Add KUnit test
Message-ID: <20250611163751-f6b7056b-2bad-4cd4-9369-9ee0f02959a6@linutronix.de>
References: <20250506-printk-ringbuffer-test-v2-1-152200569eb1@linutronix.de>
 <aEmMdirOERyv8COG@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEmMdirOERyv8COG@pathway.suse.cz>

On Wed, Jun 11, 2025 at 04:02:30PM +0200, Petr Mladek wrote:

<snip>

> Otherwise, it looks good to me.
> 
> I would push it with the timer API renames so that it works in
> Linus' master and linux-next out of box. So, with the following
> changes:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>

Thanks.

Please hold off applying this patch for now, please.
With 6.16-rc1/GCC15 it runs into fortify-string errors for me.
I'll fix these up, integrate your changes and tags and will resubmit it.


Thomas

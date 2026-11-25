Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623039;
	b=Ml7brfwj58q3qdXfnZwoL9NFAC3cWIc8l1K5yU3r5b2/OmRAkbrl2DdmMT6f74u1IOiB
	 X1iVgThrE+w0FCny//ZBruPoksRjeL55rK5HEAI98g827Eq4crwQlZwhS6MDajzHnLHaW
	 KYdw0YaTNbF01GT0ug7gG5AltSzNgLJhxZSFtN8lLMVXFxf1EPP7MA2/fd2AnHQfgE/qf
	 n+45/sifOrQsVlAPQ5IxjUkwDnD7Ir1N+3VunMbMOhETJBFwgF/AycRenYqDzEyCyuPXs
	 LUIVsXI3nYESx3MMT0eoxx6WlJAi/w/f3g8H2F+bkTkTee1cvagn1/K3E2pG4pr7Jyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623039;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O45HxT1I9aVy+grMz3O6JGbii0vdVA8+mf3TGqAUJjg=;
	b=5egmRP/Wevo6sjny0bepQe2TQdUeNlD3fkak5KDlBqHXpdILlVfFkvN1y7/GCVzY6Q9n
	 yCFiQjmGBMR8iPRPPfYgohXJkdNGpvgScm5TSjca2jAblsNYv98IrW6x8t/JujtBLhndu
	 OSxMeXq0hKB+GT1EfQTMhmoCoO94WnC4vc8Mk380zetq3mMp90YW8KpZ19X/JzJJOk92S
	 VYP/G1FsMIDV+7AcI9CN/Go6U5aO/K/U2dMVCeOIVcgEBLQDeaGDrRnqXQUy1mCpXeKog
	 iNR1iZBYCfzN/k2rCGQY/7yBFlfxU2do9aCpWkidw8ttkRmBhMv2cYHzTkMkC0NeRTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGp8jYQu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 65D63606A31E;
	Wed, 25 Nov 2026 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGp8jYQu
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A747A1F000C4;
	Wed, 25 Nov 2026 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623038;
	bh=O45HxT1I9aVy+grMz3O6JGbii0vdVA8+mf3TGqAUJjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hGp8jYQuXSlhsQGxVeBbuMyBTP2pN4voUsjE0oKeBVZDvRGyJpyaqIinjEce2/WAf
	 1gP7VVR4tpZg7cn+YQhMJ1t2F7FxFhw6vr9M0wnPXZB2XJOD21B1+csb4JflkF1bS3
	 SsnDMWjpR9OzpTGRhZAI3fzAPil0PUL9rVjFwy5Sen5oqzkLrosiJHAq7mZ0FWOsyW
	 l2oFc53MoRiGvFvPIDuw/5yiAIsh+Ca0sfQpmwYphgAKSfDwa/hb/BHJG9fYYTaQgM
	 1dtF6MR7gj+b+kZyQoNO02gfS7+fwi7P2XhcJwXB0U8L2YXHQ0p0OtOCtuvmcdbMbc
	 zYiu6yMFSZgow==
Date: Wed, 25 Nov 2026 17:10:35 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 04/19] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>
References: <cover.1794667407.git.alx@kernel.org>
 <7fc1321995f1aec9d7b92c6a89047cc9fb28c52a.1794667407.git.alx@kernel.org>
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
In-Reply-To: <7fc1321995f1aec9d7b92c6a89047cc9fb28c52a.1794667407.git.alx@kernel.org>

On Sat, Nov 14, 2026 at 04:22:16PM +0100, Alejandro Colomar wrote:
> str_has_prefix() returns the prefix length on match and 0 on mismatch,
> so the mistmatch case can't be told from "empty prefix matched an empty
> string".
> 
> For instance: the OF root node's name as returned by
> fwnode_get_name() is "" and will return 0 for any name matched against
> it and since len is 0 too, fwnode_name_eq() will return true.
> 
> Let's use strprefix() instead, which also makes this function simpler.
> 
> Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
> Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
> Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

This series has grown substantially since v1. My GPIO series[1] depends on
fwnode_name_eq() working correctly so I would really appreciate it if we
could queue the bits and pieces fixing fwnode_name_eq() separately and sooner
rather than later (it should also be backported to stable).

Thanks
Bartosz

[1] https://lore.kernel.org/all/20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com/

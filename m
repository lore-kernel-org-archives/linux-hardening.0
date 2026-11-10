Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320600;
	b=oHkNrA8VARrGqd313PG4GcY7IgzeRizisKtUxQPmC0Nki9Z5htjVb6YWrHCdDaCwkwPm
	 7Fn+3GBk/cHIU3jJdJ1p87ojl8u7oGxg4Whhntfe9zjhuPgxHIso5yLphMR/F7Yf0BlyX
	 s3SL399B+JnbYbqF9hSwvo+R03FQzWsweehjDNE0tiuu9/H+S0+LObVDDtKAOMW+1CXsU
	 nmtRbK9uNIuPVqI0OSzYievPvfvd/si8czSZxmqTXJKZVkhjifCwcaAd+n6ifciwXauK/
	 PaqtaAg8/JixdLjjTDrmRXyfInT7TQXj+YswLMUUwl5MREHC8T1FtdMFRPgzI/b/9pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320600;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3B7CtILb3LLO9q+THe0t5ht3uVshXwChn80xi7KOiak=;
	b=UEiAAOdNCDGsseS8SFtTC/m7ULRgS7l/Rzy6kmFjsjECwgOxBtOteCmj4nark3t493cj
	 IJbkMZMytEaZ3TVzx+veVOOES4OnlhZbkZgcUrxGyzVG7v8+tvpwYKWQel5FeIN6pPba0
	 7mRJgvXDFow7+2jTeCWW2vuRvbKljEXBKSLcoRjoWxHZO7s56ZqKTXpljLXdCzBU4di9A
	 6WyPmqNoya8bgGz/o+bmCvD3VW+Bgh1YEQJqHIY8GEs7cjGAGzQYVIlxzBM/hNIfHKswL
	 85wwtR5KRaaeppELPoLLfKxOGo72hlU5fl1kZxV3W/pCAQgWwFG+wpVpjpspXT73GuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqinskO5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7D3D8606A325;
	Tue, 10 Nov 2026 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqinskO5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A25AD1F0089F;
	Tue, 10 Nov 2026 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320600;
	bh=3B7CtILb3LLO9q+THe0t5ht3uVshXwChn80xi7KOiak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eqinskO5eMgPYMTCrXUdZfO5Vf3gIJLFfRp1UCy6RBOuLCmE5myW+Fg8gakN7cqQ3
	 15d2sujTkCMLobLAtCKtr838Z6VgOEmKU6dMAG5OUjX7MPS0sxnDXNNv94fvExoPoY
	 07k6hHxMNxF5RLu/7IkgemiZPXseddbNzyBpKGhFkyl22ekA1u/L8uHziVFDW0vNEK
	 WesXcWZ+2N0sjHLjJKcG2gWTR0ZDN2qrzejMJZNZy5ODNYBGA85RKejXjiANlDYWaO
	 8Wb/mnp4SvYBLArzQVDW2oimsXx58/abksSS3b9ZSB9nVoXwJiyKzVgSm68J+TpDla
	 EfeNApjSAv2lQ==
Date: Tue, 10 Nov 2026 15:23:16 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <p5y6f2vrber2i56lbzjvd2bnyjxde45g5arqa6wcuz6nd7xqzl@bsgjktsfgnky>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com>
 <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>

On Tue, Nov 10, 2026 at 10:50:57AM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 10, 2026 at 11:12:02AM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 10, 2026 at 11:00 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
> > > On Mon, Nov 09, 2026 at 07:28:33PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 09, 2026 at 02:07:46PM +0100, Bartosz Golaszewski wrote:
> > > > > On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> > > > > > On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski wrote:
> > 
> > ...
> > 
> > > > > > > +               names[i] = kstrdup(prop->name, GFP_KERNEL);
> > > > > >
> > > > > > Can property be statically defined somewhere? We might want to also optimize
> > > > > > these duplications with const variant (here or elsewhere, for fwnode generic
> > > > > > path, I believe).
> > > > >
> > > > > Please rephrase because I'm not quite following what you're saying.
> > > >
> > > > Can prop->name come from something that is declared as
> > > >
> > > > static const ... foo = {
> > > >       ... .name = "bar";
> > > > };
> > >
> > > You can't know it for every instance of struct fwnode_handle, so the
> > > answer is: no.
> > 
> > I believe I misput my question. If there is any potential that *some*
> > of fwnodes use statically defined string literals for the property
> > name? If so, kstrdup_const() and friends may be a better choice here
> > to save some memory (which is getting more and more expensive these
> > days :-).
> >
> 
> Ah, that makes more sense. I'll look into it.
>

So I believe it doesn't make sense to address it just yet. OF nodes are
created dynamically. We could potentially make use of it for software
nodes but let's cross that bridge when we get there. That would require
making kfree_strarray() const-aware and use kfree_const() for the member
strings.

Bart

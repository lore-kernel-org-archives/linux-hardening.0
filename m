Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319614;
	b=DwsuItT1Idy3mX21AWswMeJVmbz882QHMXjx/U4ASZAdjORTiUMXXCwLwR57ah85s6cm
	 P65np333zKqMBNryl/YxfK9AW5/Dm6SgjYJ26+B7Bn5A7upt3krQB4KdJz2wiep6285Rt
	 LeWvIWhYwx1sNAsMni1QkANsuF66OzejwWk7fchIBtHow1CyEx6QhpCCyovfXtTbzxvE9
	 imHc+0IlK6lKBfHP7bfECXC+7OygCPErlM2jxZUe9Xr1GjDef2lWfvI29s2FDDisTYMaE
	 2CH/v2elOwNfsEVvT4xnrcLsySAjHvJmCW9yEX5RgUV1bgItKHXv1MWdIgZVcecPK2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319614;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6mdx737bcxeVcciGfuHgnMznol7+4MpQaOj9g4XVWL0=;
	b=WcBNa7O1XUUxt5lLStrrp8jaQ7efVi5lQQGJIJeuzQSrtmSo2MhKWc9v+sN4/X3QNnEB
	 J6x6R0kZzCXiA1JM6tNp+KnOOfWh/V2qsh6OwpTZO6Roc8e0uDdMBif4+/dj4ClMtfgMg
	 FK+vQrVaFWl0kWXVT+vT5iiaOAM06N+24aCc6syASX2w2jspIJxDXFYAbFJcANLHa4/Lz
	 n4jGrRpj/t4yYNo40ISnDextn8bcdF0oyUFsxchLeDcN9Q/ST6mx0ZQ8XpqXjKBusvGbE
	 1b6ZolRfsAFswY5Ypg1SNr/SIwj+B4aeOaxEeNYmMscTin1yliH3+gyHH9qEuCL4cZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPYmvbsb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B8F2D606A321;
	Tue, 10 Nov 2026 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPYmvbsb
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CAD501F0089F;
	Tue, 10 Nov 2026 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319613;
	bh=6mdx737bcxeVcciGfuHgnMznol7+4MpQaOj9g4XVWL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OPYmvbsbYEIAyqQ66foGVr6ozvMzlKC/en38xqcdxVQU0194eo5B5cptbbZlk3FLj
	 qjGNveKQdTK1fN7MKM+xFNGe9chMw0b0WEdx25m3+F3JSvLh1z0L9Ka8ZEIeUEbU9G
	 C/dLvCsb8iG/f4N1k9xrHxvLk10X3p/cafIzVXoTCFJK62SV4Ky8ze+UI7VYWtxxxH
	 CxS+KsSNb+UMi/8hIiodrdCDFOEwdfXqd0F3TH0ysqUr6TBjfzgPVAPaSLxhrx49d9
	 TgKEVCV1O4elPHxm6ocTfStWrv/pZtE+FKVIIWtx41H5VYYtZrx84xPDQwLNgJAHcV
	 p6vTXvGrT2tbw==
Date: Tue, 10 Nov 2026 15:06:50 +0100
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
Message-ID: <42haexjuvyhxznlre4wtwb6ent3epgnqn6mvj2pjxrbryvy7yt@2p7odc4trzo7>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com>
 <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
 <CAHp75VdZpqt8PzVypQ85U1OjxszXOmCP9MKv3ozQOh-UVFnR-w@mail.gmail.com>
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
In-Reply-To: <CAHp75VdZpqt8PzVypQ85U1OjxszXOmCP9MKv3ozQOh-UVFnR-w@mail.gmail.com>

On Tue, Nov 10, 2026 at 12:51:53PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 10, 2026 at 11:50 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
> > On Tue, Nov 10, 2026 at 11:12:02AM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 10, 2026 at 11:00 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
> > > > On Mon, Nov 09, 2026 at 07:28:33PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Nov 09, 2026 at 02:07:46PM +0100, Bartosz Golaszewski wrote:
> > > > > > On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> > > > > > > On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski wrote:
> 
> ...
> 
> > > > PS: is there a way of using match_string() with non-const data?
> > >
> > > Why? It's an input parameter, it returns an index. Whatever you
> > > provide will be not modified.
> 
> 
> > What I mean is that the following change
> 
> > +               ret = match_string(merged, n1, sec_props.array[i]);
> > +               if (ret >= n1) {
> >                         merged[count++] = sec_props.array[i];
> >                         sec_props.array[i] = NULL;
> >                 }
> >
> > Results in:
> 
> > drivers/base/property.c: In function ‘fwnode_property_get_names’:
> > drivers/base/property.c:607:36: error: passing argument 1 of ‘match_string’ from incompatible pointer type [-Wincompatible-pointer-types]
> 
> > And I don't see a good way of working around it without doing:
> >
> >         match_string((const char *const)merged, n1, sec_props.array[i]));
> >
> > which is ugly.
> 
> Ah, got it! But why is the "merges" char ** and not char * const *? I
> believe that will fix the issue.

Then you won't be able to assign dynamically allocated strings from
prim_props and sec_props to members of "merged".

  CC      drivers/base/property.o
drivers/base/property.c: In function ‘fwnode_property_get_names’:
drivers/base/property.c:601:27: error: assignment of read-only location ‘*(merged + (sizetype)((long unsigned int)i * 8))’
  601 |                 merged[i] = prim_props.array[i];
      |                           ^
drivers/base/property.c:614:41: error: assignment of read-only location ‘*(merged + (sizetype)((long unsigned int)count++ * 8))’
  614 |                         merged[count++] = sec_props.array[i];
      |                                         ^
drivers/base/property.c:619:16: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  619 |         *props = merged;
      |                ^
make[4]: *** [scripts/Makefile.build:321: drivers/base/property.o] Error 1
make[3]: *** [scripts/Makefile.build:603: drivers/base] Error 2
make[2]: *** [scripts/Makefile.build:603: drivers] Error 2

This is where we could use kstrdup_const() but we'd have to keep track
of these strings now in error paths and that complicated things. I'll
just keep the existing loop I have.

The alternative is of course relaxing match_string() or introducing a
non-const variant or even hiding the variant behind a macro using
_Generic(). But that's work for another series I think.

Bart

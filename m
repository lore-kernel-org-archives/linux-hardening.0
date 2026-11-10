Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304257;
	b=tItLN0e/g6YMXGMGLhv6hIfLLufMWUXbod+F76w+T9LJNQzyaxo/360b3g63C0T68fg8
	 i1kcvrmAN5EZUfWNaXPFnJ7d7SM26QrEWps0mmUDbY5j6P3tj+9iUh9ERZYCuKZeuC4KS
	 IofHeGJUu5cyR0KjaAzQUwRSKysrpJcdSUJzX2scPk/lbhCZAprr6dw9z3dUjSYDON6t8
	 Ji4EsFAmpD+rzdJKSeMM6Mba31W0OuHN5S/x/8+mYXRX6hV6qEKGvapewBdCpvwxmT86n
	 SHf903YAlQx/Ge3jRxOv7uctC0AKjirgMFPpeauKzZgY3F6DoMMz/qmQ0TzrrDN/5Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304257;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=e3//m6z05CCr++yJ8pEIRKHvzyBVaUWMryM2WqTqQJs=;
	b=e5zncX4kvOERDBgVSJwQjqOcJQnMph2UrYsCeq+2vy5nXA6mEJ2cO2rdil21avnNEckW
	 8PFSvDqK0/KGmVpghaMOzh8MfsEAvoY3GvmhI0erC19mMkWZmXN7FZdo1oCddPfWJhLW6
	 Yaycqu1/KRMacnNlpdaB/rfxULTQqMzo7nds05Ng8p53GHUeglNrpzpPmGD2IpHUyDmHE
	 guSArupINd8F6GUBWYYMirURl61pQibEfJS5c8/W21ZJKEAldOdqaYzUPsGOzZa8Q3aXe
	 4X5pu9kCij8LKd3p/OSQ+gCWuU59+xGuXFrlYdG+vGiN0gasOh5jYcDhiXtPb6Fedyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N70KADS+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 84D53606BF07;
	Tue, 10 Nov 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N70KADS+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A5B851F008A3;
	Tue, 10 Nov 2026 09:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794304257;
	bh=e3//m6z05CCr++yJ8pEIRKHvzyBVaUWMryM2WqTqQJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N70KADS+ISsQ/NyHQkqIdHNIS4xgAvB+H6oPlzBasLeGPdixmDRbQb7KeWAIoe9Lk
	 kRYG5YOAEhhWJX2sNCu3Pl7lonBwby+ZinIhXmEVJnL7Ahy4k858wH5kVGZkrgCu6j
	 cP+B0aTnXONg0wJLIkW6H15r/gPjegA9ItVuhv2pQcuMkOX9N7Xpkl+eC91lLS5+7l
	 wwHWocYvbB9wrTQfJy15fVIxT/htEEAzVJHQREUniV+3bvxHSXPd/bcOo18glzhX00
	 wF5Sboa1ktHhMPhaTL4wQZYA4psu7VYQthoawI/ejYlQrdgM+DIxpcltAR7QTnXQtC
	 uUWH3gBEmHlxQ==
Date: Tue, 10 Nov 2026 10:50:53 +0100
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
Message-ID: <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com>
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
In-Reply-To: <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com>

On Tue, Nov 10, 2026 at 11:12:02AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 10, 2026 at 11:00 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
> > On Mon, Nov 09, 2026 at 07:28:33PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 09, 2026 at 02:07:46PM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski wrote:
> 
> ...
> 
> > > > > > +               names[i] = kstrdup(prop->name, GFP_KERNEL);
> > > > >
> > > > > Can property be statically defined somewhere? We might want to also optimize
> > > > > these duplications with const variant (here or elsewhere, for fwnode generic
> > > > > path, I believe).
> > > >
> > > > Please rephrase because I'm not quite following what you're saying.
> > >
> > > Can prop->name come from something that is declared as
> > >
> > > static const ... foo = {
> > >       ... .name = "bar";
> > > };
> >
> > You can't know it for every instance of struct fwnode_handle, so the
> > answer is: no.
> 
> I believe I misput my question. If there is any potential that *some*
> of fwnodes use statically defined string literals for the property
> name? If so, kstrdup_const() and friends may be a better choice here
> to save some memory (which is getting more and more expensive these
> days :-).
>

Ah, that makes more sense. I'll look into it.

> > PS: is there a way of using match_string() with non-const data?
> 
> Why? It's an input parameter, it returns an index. Whatever you
> provide will be not modified.
>

What I mean is that the following change

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 40fbf01a9faa..1c43fd2c8d57 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -563,7 +563,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
  */
 int fwnode_property_get_names(const struct fwnode_handle *fwnode, char ***props)
 {
-	int ret1, ret2 = -ENXIO, n1, n2, i, j, count;
+	int ret, ret1, ret2 = -ENXIO, n1, n2, i, count;
 	char **prim = NULL, **sec = NULL, **merged;

 	if (IS_ERR_OR_NULL(fwnode) || !props)
@@ -604,12 +604,9 @@ int fwnode_property_get_names(const struct fwnode_handle *fwnode, char ***props)

 	/* Properties from the primary node take precedence. */
 	for (i = 0; i < n2; i++) {
-		for (j = 0; j < n1; j++) {
-			if (!strcmp(merged[j], sec_props.array[i]))
-				break;
-		}
+		ret = match_string(merged, n1, sec_props.array[i]);

-		if (j >= n1) {
+		if (ret >= n1) {
 			merged[count++] = sec_props.array[i];
 			sec_props.array[i] = NULL;
 		}

Results in:

  CC      drivers/base/property.o
drivers/base/property.c: In function ‘fwnode_property_get_names’:
drivers/base/property.c:607:36: error: passing argument 1 of ‘match_string’ from incompatible pointer type [-Wincompatible-pointer-types]
  607 |                 ret = match_string(merged, n1, sec_props.array[i]);
      |                                    ^~~~~~
      |                                    |
      |                                    char **
In file included from ./arch/arm64/include/asm/processor.h:34,
                 from ./include/linux/sched.h:13,
                 from ./include/linux/ratelimit.h:6,
                 from ./include/linux/dev_printk.h:16,
                 from ./include/linux/device.h:15,
                 from drivers/base/property.c:11:
./include/linux/string.h:336:38: note: expected ‘const char * const*’ but argument is of type ‘char **’
  336 | int match_string(const char * const *array, size_t n, const char *string);
      |                  ~~~~~~~~~~~~~~~~~~~~^~~~~
make[4]: *** [scripts/Makefile.build:321: drivers/base/property.o] Error 1
make[3]: *** [scripts/Makefile.build:603: drivers/base] Error 2
make[2]: *** [scripts/Makefile.build:603: drivers] Error 2

And I don't see a good way of working around it without doing:

	match_string((const char *const)merged, n1, sec_props.array[i]));

which is ugly.

Bart

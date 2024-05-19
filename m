Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367A39B;
	Sun, 19 May 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716083931; cv=none; b=E2XWJ7dP8evJjOqdjiQh0UKhyVl75p9ac+8Zw6bhfrb5kbRt/H0X8kWWC5XAOJVd+jk4CoyJ+zp7ciuRLgPG4A277PUiazz69AIdd9OaYeb8HK8PY4zH9O95mNXCxqk/mV5Cc7rQeon0pd3HZvS+iC8eu51z8COIgsUqrFBIZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716083931; c=relaxed/simple;
	bh=v5NrZs6GuCD77xD6BSwxwS3QTpgJ5pqa2G3WKOEcpWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNOcpSN8qXpgi7i1HHsmfa95z8LRRGECVM7qey6OT+5RHWEQrHaT4Tsg44m1QD62tRts47TUzj1A65Zap7T7LP8TpK1z3HcZnVhQHxhpywhbjkAd1F+PdoO6/xWE2px03t26aTbOTymi92fiok4z2lMtknLCkcnFi5d3628d+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0BF52C056A;
	Sun, 19 May 2024 01:19:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id A84B020027;
	Sun, 19 May 2024 01:19:19 +0000 (UTC)
Message-ID: <03cc262da2a3db817aa5663fbce6c914708b74f8.camel@perches.com>
Subject: Re: [PATCH] drm/nouveau/nvif: Avoid build error due to potential
 integer overflows
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: airlied@gmail.com, dakr@redhat.com, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, jani.nikula@intel.com, javierm@redhat.com,
  kherbst@redhat.com, linux-kernel@vger.kernel.org, lyude@redhat.com, 
 mripard@kernel.org, nouveau@lists.freedesktop.org, tzimmermann@suse.de, 
 linux-hardening@vger.kernel.org
Date: Sat, 18 May 2024 18:19:18 -0700
In-Reply-To: <a912c2d1-9008-410a-92cc-912e17c63695@roeck-us.net>
References: <20240518143743.313872-1-linux@roeck-us.net>
	 <34a6d812-b4ed-4465-b0ec-e641d185b9b1@wanadoo.fr>
	 <202405181020.2D0A364F@keescook>
	 <a912c2d1-9008-410a-92cc-912e17c63695@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A84B020027
X-Stat-Signature: w3iik6tbsay1qy16e34mbnwb8cwgnmib
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19bAkmZyo+dJgltxs9NfI23KEnolHXqvm0=
X-HE-Tag: 1716081559-138596
X-HE-Meta: U2FsdGVkX1/NTsnVtjEKYHeeHCzZZWbJc+2s8OyWMfrImO+5aFN+RcWD+M6lUiPJt90JXXVs6VNH9RVnjo0SIbesh5wlYX/L1/Js40Zh10YqeTQ4A1BqQx71+JOEhyzPPcQvSopjounJG+N+Brc38ie+i/JEzH6Hx+tyhKpHLgy47jtUB0yWXaMZQ8gWS8Q8j6gtIR05ZXdxHqPou0c2d1TrTLTjCo1chif3e5HhxrwGcOM7bFFJ928ZMzqD6+OMWtKPVnqWIDQNS5IvOUo7UGzlQBvO+QZ0jEPkO3HnATz0taCXaujQL+UZNKdHjWp3

On Sat, 2024-05-18 at 11:23 -0700, Guenter Roeck wrote:
> On 5/18/24 10:32, Kees Cook wrote:
>=20
[]
> > I think the INT_MAX test is actually better in this case because
> > nvif_object_ioctl()'s size argument is u32:
> >=20
> > ret =3D nvif_object_ioctl(object, args, sizeof(*args) + size, NULL);
> >                                        ^^^^^^^^^^^^^^^^^^^^
> >=20
> > So that could wrap around, even though the allocation may not.
> >=20
> > Better yet, since "sizeof(*args) + size" is repeated 3 times in the
> > function, I'd recommend:
> >=20
> > 	...
> > 	u32 args_size;
> >=20
> > 	if (check_add_overflow(sizeof(*args), size, &args_size))
> > 		return -ENOMEM;
> > 	if (args_size > sizeof(stack)) {
> > 		if (!(args =3D kmalloc(args_size, GFP_KERNEL)))

trivia:

More typical kernel style would use separate alloc and test

		args =3D kmalloc(args_size, GFP_KERNEL);
		if (!args)

> > 			return -ENOMEM;
> >          } else {
> >                  args =3D (void *)stack;
> >          }
> > 	...
> >          ret =3D nvif_object_ioctl(object, args, args_size, NULL);
> >=20
> > This will catch the u32 overflow to nvif_object_ioctl(), catch an
> > allocation underflow on 32-bits systems, and make the code more
> > readable. :)
> >=20
>=20
> Makes sense. I'll change that and send v2.
>=20
> Thanks,
> Guenter
>=20
>=20


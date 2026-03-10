Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844543B9D93
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180587; cv=pass; b=W/WG7aMsRLRNPbaUepoPiCZP11HuWmtH8FuNjamZN4j6htjonQkZ6imNihKDnsHV0tXPLZBmnz8MLgSa6CLYpH4Fr5RuhJbOihJwXXrRKQSq8+kyFZZw+2PeRuBHqJp36DQpi/eD5FUIRWIBlYYwfKB9St/dsLwlgDIqtcyxCZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180587; c=relaxed/simple;
	bh=8bqnvy6tw3ei7IVgNH12ckvped+fzaE9OLBfWEhcJGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4PVgxXJBFccMW7PU1tIjDKhgx3rKV4X7rMjrK1aCLub8nKH+Y3xNdpWNdVWvBQ5ibBpJlTK7eYFk4RAmBNurfFmQPzcIHl+Esi/xsF1YMchvxkT43rkkAlcWrEvyF3CpdJ9+ve+1Vn+XgFQiC7KzdXdfw8N2pOZvadv8P4ZcVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXsRCycy; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXsRCycy"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-660a293515fso14423108a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 15:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773180583; cv=none;
        d=google.com; s=arc-20240605;
        b=LEfQAkpszB2uA9/Yg/f4mo2g2zGupOzF2LK5IOj30gTe0iSBmAOMCyFYLNKBMw+Ig+
         RD8hd3PWA0EDdmrz1QJyI0p+Rr/2eedG3z+S845n5FjiBL33kDVLokqJmxkpOj5PDrEa
         8HtZl/6LcaHXcDCyQfTZTXH0rz46klXG67AcQ4aWaxZgaTwC/naTuSrhjSL857TVM8Em
         e4tzrQ+pI+s5+zNmylZq1MqeRVknyAK8FCL+OYR7v0LIrt72w5n6TI8agU21n12Nxssp
         yUYjS3AbM7MBitc4ie77cBqPgLsepTdg9wx8cdy9Rnr0Ig0rakWo43h1dShz/ZOEAczI
         56NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G14QlrkUQYZrsZEU3mNgugV18F+7WJShti7BJQaO9TI=;
        fh=cfh+ZQpIkgIHsxYFOoTligIU2gLaGYtvX7odrLT+b70=;
        b=CAW6sDe3A5/Nww2+jNELpFeF8FGmYt70Qr0u6+8GO6V1sJvhjRhKAMI4UwFwR4owJ5
         Jk2uiYvnLri0Gl/AMhZ8LQXWxnaQv9zpnZKQZ9pT4rKSU8IiI8OdvYrxnD9mgM9646CF
         jN1zA4prTHbyf3XYk8AWCkr/JpNus3PvXjag4VxcRc1Nk/eVa/VCGcDXhfIbczvLFMdR
         n6Hvnm870j1coTyuaUCH9I4rwII/0BpXH2ZHUogj9/5sbVOgeILDeFry0skNhWs2yryT
         pgNkVGUnPty3XSV5/CDi5GUttbetqK0T44utlLoj7ZJ1rGI3BEm0cIvixey3W2SfCPzm
         juAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773180583; x=1773785383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G14QlrkUQYZrsZEU3mNgugV18F+7WJShti7BJQaO9TI=;
        b=bXsRCycy806ZeBz984V3lfrdbYhs57X7xL5I/Jn3wJzTZDngaqOeX5L9Jr49cH6TQT
         tr3Ic62lTzew6EGsg+eo03EGG1SDfEfhus8xi6jMM+GXrf4/QY9C5tpgV1csGBG4f4y+
         12phHR1jH8WwtYWEllnaZMaPP1x1LleQZLvoVX51NOptVwXjdnJ5vSe/8qWxoZWDMV1u
         FmdW7lRWZdeteLXdwop7leWgrpagkiHUQRVpsgbZjjzfbOpcP2A/E92kv80kQLhVyHh1
         iPRUj0vm6FIwzYENsrnDTL8lHQBuJs30Re9KqLlyK/8G4N25McInBklUDhYE5Ql8bcCj
         q2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773180583; x=1773785383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G14QlrkUQYZrsZEU3mNgugV18F+7WJShti7BJQaO9TI=;
        b=HAWNLi7C8xXA9r33A3+yA+vdeTKTD/98wlzC1Vsjd6aLPiWrKXTH5Ba2fTY72E/3pQ
         0pscZ0j1nMsVUQa35dCYgjjhiDFyuGMp8rb3GrYRBV4L67OmefwvVduXdJiWc7nOotOu
         ZvFZymcSUhOnMBDd6i9rJ9egSeGYOxaropytOylkrBssrjhXG8AA4vq256MdrWiwRRvh
         BvyvobmEZV/A0hgLWl4wn5/GyNUb6928jMcfmA+BzwBvaSaaPOEdZX/CMDxNlTZBpo9C
         ukEM6GjIdb1eTbvg7M/91f0wPOTXeoZAYRDTIIYgT0OMY4XQlOMFfdLB38GFhBic8WRr
         smtA==
X-Forwarded-Encrypted: i=1; AJvYcCVKNGlvcIGMMvsrmLQvM7xMbZ+APBnfG98kN6tTTJ3Zw6bxhEAGe3eCLFgjAlENOUiphXyMJDeFsJ1q55f1g6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ41hSHbzdCe8QrcA8ZKjEUZ7HiFAxJy8Zp8k0Qqt3tbye2H7X
	CyVXnFJSrkxJCWFPG2eO92bAFx8myXRw7x0en2zOOFOv0FZOoroYWvW8XEaLMwemhcoWAZo25NC
	rtErDbMqQhVcg+INYyTLi68NZ4EisFE4=
X-Gm-Gg: ATEYQzz2APSEw1bxZwhEjyzKCeQ4+qKNEzbq7qaldYHFYd8PP8VviNr5FHgQPH1AZya
	7wRAIlzg6PNlbee8bvyJ2n3r4GzY7p3qoO+wCSHQwywsB6CwK18MrcX/lGOIgHsBBxzo3HOMDl5
	v7qTxMLHikzl0inLvmNmTtJcj90TENHFKZnTI5o2Q5oU6bLcf1DGPxd6C4RJ1J+3J5Su2gPRmPU
	MLtjKFhUFjwNksbxkPQAN92+1BLl6y2yX0jDG9SGWBlg+lAbwgNyQg5ptduaXubtOJa2CFg0Ubh
	HBGz7qhkdTgovrko7lgeunFAGRyyijwg6Ffb5ZFUfMmnA49Nf8f8SvhK5e+mn/+83T2Wh7xWr/m
	6Ee2n0Q==
X-Received: by 2002:a17:906:f5a8:b0:b73:8639:334a with SMTP id
 a640c23a62f3a-b972e191bb6mr10286766b.13.1773180582581; Tue, 10 Mar 2026
 15:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308211220.33759-1-rosenp@gmail.com> <aa_SahEg_NzB_PJN@intel.com>
In-Reply-To: <aa_SahEg_NzB_PJN@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 10 Mar 2026 15:09:31 -0700
X-Gm-Features: AaiRm53mBmhXjK4k8PKVHMItPrvdu9s1rvZnzcH2lGj-1eqrBMYYRDEWag6CuY8
Message-ID: <CAKxU2N8x4z7Lw3mQjsnGAMxYP-K0AxLUtCXJP6btEBuTcxL7fA@mail.gmail.com>
Subject: Re: [PATCH] drm: dp_tunnel: use kzalloc_flex
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:12=E2=80=AFAM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Sun, Mar 08, 2026 at 02:12:20PM -0700, Rosen Penev wrote:
> > Simplifies allocation by using a flexible array member to remove a
> > second kzalloc.
> >
> > Added __counted_by for extra runtime analysis.
> >
> > Simplify assignment loop. It always returns true. That is,
> > max_group_count is always equal to group_count.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/gpu/drm/display/drm_dp_tunnel.c | 26 ++++++-------------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/=
display/drm_dp_tunnel.c
> > index f442430d8de7..aad1605b956e 100644
> > --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> > +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> > @@ -188,13 +188,13 @@ struct drm_dp_tunnel_group {
> >  struct drm_dp_tunnel_mgr {
> >       struct drm_device *dev;
> >
> > -     int group_count;
> > -     struct drm_dp_tunnel_group *groups;
> >       wait_queue_head_t bw_req_queue;
> >
> >  #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
> >       struct ref_tracker_dir ref_tracker;
> >  #endif
> > +     int group_count;
> > +     struct drm_dp_tunnel_group groups[] __counted_by(group_count);
> >  };
> >
> >  /*
> > @@ -1893,7 +1893,6 @@ static void destroy_mgr(struct drm_dp_tunnel_mgr =
*mgr)
> >       ref_tracker_dir_exit(&mgr->ref_tracker);
> >  #endif
> >
> > -     kfree(mgr->groups);
> >       kfree(mgr);
> >  }
> >
> > @@ -1913,33 +1912,20 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev=
, int max_group_count)
> >       struct drm_dp_tunnel_mgr *mgr;
> >       int i;
> >
> > -     mgr =3D kzalloc_obj(*mgr);
> > +     mgr =3D kzalloc_flex(*mgr, groups, max_group_count);
> >       if (!mgr)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     mgr->group_count =3D max_group_count;
> >       mgr->dev =3D dev;
> >       init_waitqueue_head(&mgr->bw_req_queue);
> >
> > -     mgr->groups =3D kzalloc_objs(*mgr->groups, max_group_count);
> > -     if (!mgr->groups) {
> > -             kfree(mgr);
> > -
> > -             return ERR_PTR(-ENOMEM);
> > -     }
> > -
> >  #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
> >       ref_tracker_dir_init(&mgr->ref_tracker, 16, "drm_dptun");
> >  #endif
> >
> > -     for (i =3D 0; i < max_group_count; i++) {
> > -             if (!init_group(mgr, &mgr->groups[i])) {
> > -                     destroy_mgr(mgr);
> > -
> > -                     return ERR_PTR(-ENOMEM);
> > -             }
> > -
> > -             mgr->group_count++;
> > -     }
> > +     for (i =3D 0; i < max_group_count; i++)
> > +             init_group(mgr, &mgr->groups[i]);
>
> This breaks the error handling.
>
> Hmm, actually it looks like it already got broken by commit
> 8e6da25bd60d ("drm/dp_tunnel: Switch private_obj initialization
> to atomic_create_state")...
I can't comment on that.

This patch does not touch that.
>
> >
> >       return mgr;
> >  }
> > --
> > 2.53.0
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

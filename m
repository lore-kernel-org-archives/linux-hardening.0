Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E412BEC41
	for <linux-hardening@vger.kernel.org>; Fri,  3 Apr 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233034; cv=pass; b=uA0l2Vj3br87mrlQKlfZ+XJo/bAbcuHJndwqNAj0nSQUD+M+ivt9bqEJgEVLcuY8ywxb9X50uL4W0eMefGBm2IpeykHf/SRNn+VyAhQVPGl1nwOs6OptX+gZAyljsmoraeqPih42dkIIGc+LxjGURFEfIiIcu9WGNf292vVCyk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233034; c=relaxed/simple;
	bh=bVAa0tVPrl+ZZraVrERiR3LqXKceJKqF7eRVzJwAxxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laSeRQPpkkpcWvyVeYw11Hb3v2JCsNJF5/QfeAVciEGo2IuZAii5Av2zmg9dlH5jsoCf5cZ/vd8xpAOEa2K/iNS8WJy8o8rmYi2BXLMgBbrBTXyZxomINGh0st59J66bqe3sH1dBgSEjKnB+grKsGJn1/FXQnzoF3n7RZ+IKh3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koUJ21BW; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koUJ21BW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfa33a983so1297318f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 Apr 2026 09:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233032; cv=none;
        d=google.com; s=arc-20240605;
        b=CrSuF+7NjVzqN422DD3BPg5fuFuecY02DS1bBGBU+mGV9/D3dn/ouzDAzpfjEYVpn0
         B/G506AacNUms7idf4/aHV/TbY3bOqJbisGzchOC5+D5leRRzC7dZypVeJNEU7Zcq/jY
         x5cKYgxsc7/GDe2OqLChuZ2Z9VsCVA6J6m9s/CTDZz1K6d1EceaibVrIugf3k7ub3D1K
         KtxfSByTaarBCkf/MrYSn0uq6JYOg6fERwuIiUZWnHdBWCZ7KCuZvMkCGj65YgN68040
         oI1VGoDtNP6zi1wWkJS0FGX3cfjNMuDlPgGKUuOTIlBsAMSJjoBagXbgkbR/54yNJH6c
         2OXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXczfDsnuZ1eKfjw7AeAQOseIwph1DmUQJxKWp4dMng=;
        fh=WQrFqNJ+QGc3vvKtg3M+5au74aAvbgHJwy4DL8Sz8pk=;
        b=N9Tci591sxcJOTQ7CptU480fa6RbrdRlOHMGZ7M9K0HbsgzUWfgo8jTExdPJIGHN7C
         6AAkRiXK4+IgXB6jAnnN/ctTG8TIbA1w6unHTHidAk2iEYVU5Ukx9eQ8xta/uL19/+mw
         gfoXEoQ8mfr4lD2lvyxbgLlJnzZKenz3nFzeqhros8od/DP/OVkXygIc+2pJcgXNYR0c
         TENG7TUV+/EoneRP/0CbCsQcMqsYRAGkb+BwxyfO9AF+fMTO7m/GJ50wkOu4ysCGkxLc
         lv4LEOjxfQXHxoGnog8U6zxfce2yiPvc+CuLcZ+6kUeRd4/sazZbQfOYyySTziunHUU5
         VPyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775233032; x=1775837832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXczfDsnuZ1eKfjw7AeAQOseIwph1DmUQJxKWp4dMng=;
        b=koUJ21BWm07sjIIltcBRGbP4BTSGB3Mbexxge7J6z4xLPzdbJ1r3aT5l52C2AgxoQ4
         zzdPw8XG/JOgRFBkQtRiBQCnJfI4TPyWvMCkka/MhrxQBemzA6K34ZRGU7crqTAG3pm3
         +oQjERddS6TxeaN3uS7/xBQi713bCQccS7Bkb8B1mEUIAO7nJQfdgh0wQBYNMCqsGtj0
         Bt5lqjLxtG837UKZHmiSWa3De0/UvDJeZvZJ8ipjIM2TM+I13gfL32jAHE3pZNz1eCSZ
         DRo0VsJnUqkO0owPl9QdB0cXtpGOj3DILv+lcnhCVpItCNeWubOw3a0/FiiD9/hWPG8O
         hWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233032; x=1775837832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXczfDsnuZ1eKfjw7AeAQOseIwph1DmUQJxKWp4dMng=;
        b=sZ+W3CQ+XSA4rI3NdgNqN2H7QUybIM/VC/XtNX82nSr/OGTOPOOVcwGPjugUqVQc2a
         ZXZS1K2gLVNwl12dNYo876+oOVfLoCgWjLLu8swhC4Bf027zIz5JxfpEt7GVTDmtt+YO
         gZeecG3e1wbuELe5k1C1px3ol3V2tiocVXMo6uo9S7a1Og3qbWOMkGs7Ub7YQf9MW7yT
         zZb8n1lFmoXqYV36Ar/5lM47nvN9xsW0GPcdvWhLviq/G4f9sK9ZUeBv6kZSWWsZoFka
         dBjhNK7xFTw97vOitM4npN8BTCnXMdqAQ3CmQQvb4dG77paYCc/eoUASP+wjjBbX7xcM
         7YsA==
X-Forwarded-Encrypted: i=1; AJvYcCVWAwUsfs8z69SUjtSYvEGa67UCe97RztQcXCYG79laueEvWvkzjrkl/TFHwJFKCrkjTsZ23auNbqi/WQq1z2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qUk150hgf62Yj2ulFAMsUdwbkm7YwBD4BRmW/DK/cX0uM0uN
	hv9HMvelt/Oeed+tdlwwSJ5yIe8K7z5kWkdRwAl+TAGSeX1XZEkofqNCo0WY0rSZNj+P7pkt/7q
	dWdoDZcClTgXjrpYrhvS4lIS9qywsoRE=
X-Gm-Gg: AeBDievPpf4rMZj7uOgamWCgEE6jymsyxjM17dS9c0P942vwksN0vH9YlVZJ1LorpRX
	17U8bvm4+EvEpOMrGLG4YwvIj3NW3i4TCaROxmBpGj6DlaAgIxFjPmn9Ij+eIh2yu/DxVqEdt3r
	sbzFpEAouWNU63cFBLwJbhqas37dbEn+m157UtmtxQkRvvVj2rGyo2OxfUX6KW+kp0Qij2gEfR8
	UmnT9/EOV3yJwq3wL0j+ZRqnAFpnEO/9CV7BmD035X8mWLN2BaNNMqdh1p+9lpih/8EnxHXuAuX
	iLFer7JJJAWouNqSvC7cVfrBzMuiAA3g6XrbrgurkXZbmpY+uu5fz7ESn1UuG/zACbe58FbYnFN
	1vNkHt6AD6ONZjLZxIBoxFvVKMA==
X-Received: by 2002:a5d:64e4:0:b0:43b:8fa4:194d with SMTP id
 ffacd0b85a97d-43d292855famr5589689f8f.6.1775233031605; Fri, 03 Apr 2026
 09:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401001130.it.781-kees@kernel.org> <CAADnVQJ+uSCvtpv4A33YeRi=_LCnZRaxB_ejVgdxPDO5u3+oeg@mail.gmail.com>
 <202604030852.D0F31E6@keescook>
In-Reply-To: <202604030852.D0F31E6@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Apr 2026 09:16:57 -0700
X-Gm-Features: AQROBzAh2gaJNAjBABQUsT-kUzYHd2Il0HjJ3W_45dy4MAn0PLbD3Ecbks_CBHE
Message-ID: <CAADnVQLso-qgaa6CxT8pmh3rwSOA5c=G=97DNJHKXSQeBLgcCg@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Sun Jian <sun.jian.kdev@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 8:54=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> > > -       strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> > > +       /* attr.map_name must be NUL-terminated, like bpf_obj_name_cp=
y() */
> > > +       map_name_len =3D strnlen(map_name, sizeof(attr.map_name));
> > > +       if (map_name_len =3D=3D sizeof(attr.map_name))
> > > +               return -EINVAL;
> > > +       memcpy(attr.map_name, map_name, map_name_len);
> >
> > this is plain ugly and inefficient.
> > Just #ifdef kernel and use strscpy in that branch.
>
> I think you're asking for:
>
> #ifdef __KERNEL__
>         if (strscpy(attr.map_name, map_name) < 0)
>                 return -EINVAL;
> #else
>         strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> #endif
>
> Is that right?

yes.

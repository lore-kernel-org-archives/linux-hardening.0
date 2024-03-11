Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5A56B7F
	for <linux-hardening@vger.kernel.org>; Mon, 11 Mar 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174086; cv=none; b=szucU1VKpD7ikGJKNLnZKy/pyQoyW2JFnQIGYLrtm+xi04odFsb6Y42+sbzx/aOoNJCCb7B274nzwMnzp5s529rrr1VBtvCzVMMc9pg108NElb0W2Ya12tJklksVya/Ia37KNcy1I60d2XtKI/MkvWudYvNI5Z+66y1vE1JKkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174086; c=relaxed/simple;
	bh=Aj2DDU2R3CP9L+cvs3h77l1rCBccotGIwcymgcAqh4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUnwJLAh65qCfRVWBOcPKV/U7bl9jrk5P2WwLyz+MsQlMRqspcYanrsaRZJDY9KFjxTdl5J/WTF2+krngfA/C3DL3aICzYsXrXywPnTaBMGBGWA/dnFnsZeSlN84DBcqurOWt//GDVfiJKvo+aJ1L4OW82iwbXo75UqoaNJRvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tbydqMK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tbydqMK"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso3958746e87.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 Mar 2024 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710174082; x=1710778882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj2DDU2R3CP9L+cvs3h77l1rCBccotGIwcymgcAqh4U=;
        b=1tbydqMK5d47mP/AaFRs9nz1D/0UrgShdiSVhxxPlu+qsgZaWxGTY2sz/C6Jhx9iEU
         huW8lbcM6IYIKN7X2pOKKaoWLojo7y3yyoEZfJSJYOulvBnuwavrcrztBTYy9avGuRH9
         UUSQ0PFIyxzBRVD8SY61mjoMmOMNOB66kUqUG/Giq2ASBuGDqtnwzdO5eXx0c2PH7Tr3
         7Px6Q5TjM+jTz2Ab5aw/sBaBGC6mbnqD5MvjunYczQ5xqj9oEgISprLXQIHDeKFUc7SK
         NDiQkxAnaF8t5H/n7OuXbz8K1BEaXXru6a45u+MACSs8PlfdAgSBMi0CoWzuREmu6jvg
         d//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174082; x=1710778882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj2DDU2R3CP9L+cvs3h77l1rCBccotGIwcymgcAqh4U=;
        b=kiZo8lA1Q4p/Km/NHUmrxUMhtwE9ebYEQgQTCOH97JJNPisAAbozTzqys/OPUT2gei
         a3mqGt+Y+obvqwqRUKEn27RmxAlMkFoioUof0JaeHkkp8rQcju9D0F5kB0LJ2gyAtt+q
         nS7gxbMF07xlRTh3LDkG2KufpcVDt5y8p+QyLnsUhZm/ElD0UsLNsS+HaaOB2TiGzvcA
         iC2oAGGtuaAU9OMkw/mQHTiLag+BgQWglKauvMxKGuZlp0ZCDkH02J1zJ42WRLa3/DJp
         T3oTicNpgXfqt/afLIKbcgTKacL0cD163Bse3OK/RXinYQRknS7qtKUoIsBypIJe3PvA
         OUew==
X-Forwarded-Encrypted: i=1; AJvYcCWKm+WLo2VTTcTvMUF/doMZE4BF4dkAN4nquYacmDwg+7d1AK9atZNBskMglEI4GTRRYWmFR+ifv3E0DZJ57DFJxJlTUXq3G5ocy9VHf6JA
X-Gm-Message-State: AOJu0YwGmxOBk/38c4Mqq5ok6WDJ8lDeGPcArLA9l6c2Dtp/b7PZQ7hU
	Luo41LJzH8l+A5EW3RTDwE7oyMVyDbluG3LfL+TdyzQx9zLD1+A+MICjorS3VD5T6+pCm8T1VMq
	rLHfQGrTnDFYC3OvTwO0xk2RKaFjXkVLFxEx0
X-Google-Smtp-Source: AGHT+IHS01FCe9haSj8hz/MjlOpYjKoCZ7p5Q//xT1au7RU9ERgiqKLg8dLzsYObrWdNTUdk4e7k8GKHb5tETRrwm2g=
X-Received: by 2002:a05:6512:3996:b0:513:4afa:a719 with SMTP id
 j22-20020a056512399600b005134afaa719mr6647016lfu.59.1710174081606; Mon, 11
 Mar 2024 09:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com> <20240310020509.647319-14-irogers@google.com>
 <20240311114009-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240311114009-mutt-send-email-mst@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Mar 2024 09:21:06 -0700
Message-ID: <CAKwvOdkGALie1d6oNXKNT8vwGmHbymsQ-dv-i0U_SQGFrhEJew@mail.gmail.com>
Subject: Re: [PATCH v1 13/13] tools headers: Rename noinline to __noinline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ian Rogers <irogers@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@aculab.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Christopher Di Bella <cjdb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 8:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Mar 09, 2024 at 06:05:08PM -0800, Ian Rogers wrote:
> > An issue was reported with clang and llvm libc where the noinline
> > attribute [1] was being expanded due to the #define in
> > linux/compiler.h (now in compiler_attributes.h). The expansion caused
> > the __attribute__ to appear twice and break the build. To avoid this
> > conflict, rename noinline to __noinline which is more consistent with
> > other compiler attributes.
> >
> > [1] https://clang.llvm.org/docs/AttributeReference.html#noinline
>
> Following this link, I don't see __noinline there - only __noinline__ and
> noinline. What's up?

__noinline (which is what this patch is changing the preprocessor
define to) will not be expanded in the presence of
__attribute__((__noinline__)), __attribute__((noinline)), or
[[gnu::inline]], unlike the previous macro definition.

--=20
Thanks,
~Nick Desaulniers

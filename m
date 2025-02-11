Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594121D63F7
	for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258165; cv=none; b=PVXlW0N+DpGlr4AwIH0+Bq52m9RSuCqaigARDm4lxyx+4MpjbaGrybUNy7M15LtbyP1NjGW3RIw8XdNiuqcdGr/QTQ5XykB313dKXDFZQzY9S4Zv2z+wd6W8th27OoJXwGbglTLl0admmXDHuV8+vpM/H2U9ffmkVG6cf0vDygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258165; c=relaxed/simple;
	bh=ygyLS/k5SRC/Sf1PUKCeZHT03EwSdItbMQEJssfmzgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/vgZBjIJw3vkcQNxzT2mdraQNjDZ1NG4+SKJyDKtnlCdYBm87NQfWNbUtZZm/b+4TGNwg6fx6NyzQ+NGCx/Qj7lvYD6pcSXgkEdd4ZmV6Ecp3mNQeQfIaXIsulIjNlndKIAONz17LKUN9sqZrulV0kIiUTq4d6Y8sBoik+8fW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phFwkk1k; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phFwkk1k"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e41e18137bso41862666d6.1
        for <linux-hardening@vger.kernel.org>; Mon, 10 Feb 2025 23:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739258162; x=1739862962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tB7lpnNqXHc5z/PkM3D4XtzXxfAlUQVDjMLNIcZD2fY=;
        b=phFwkk1kJtxjFQ3okd9NFHhJapHnxgfw0RomgXQBYuEHilW5v7TZnWE+tcQ/3mrLvC
         L1HI2K74VQBQpNjv7vG49w/PyyEKm7T0lUiUA97DNzYWM7WIr8liBbslONmT+kmf5Rdh
         2CCXK76/V/FlSndq6tA1JlzKzPD5LFRVRTNK6gq/XSoIlvYgdDtv0EkB285+uFrGYE51
         5SS+07yk/tLhsYtOs7+8W22xuBWTHW0M+z4LCNW6cI7U43jmBCuXmhzwxHmkYVrlqkyW
         2MW6kMP8qQumn4lBRXJJkXtaqhVs0olKReqAln2f50OzHBWDfb7DVYThWz8NuByPPJgd
         O7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258162; x=1739862962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tB7lpnNqXHc5z/PkM3D4XtzXxfAlUQVDjMLNIcZD2fY=;
        b=u2aqdNAUYzrSe7h8Boc05AXx4zNCrE8KUoNTDqYumYC8B8itUHTCiCf+LyCdSD41Cs
         lD/a/Oi0KoXMW10Z3ZIVFKO90KSDXkd/TLOcCVYZkBKDgB9m1bAEFSBbf6df+CSdpz25
         F2QIZjyr9QWFjsxrwZ7hV99BcpYI2i53oU7+01jp0p9mjP0njjnys8qE8G3VhdSjMRUb
         5y2UReR1Bm4A7RAWxvHKGfqJ/tDGavrKOrroZT/RGJ/oHjSGanEeIJeYk7Yf/eJ7EB9t
         lJNd03EdqN7tqyp5g+bdyFDEXPUto1pHMafVEMWpWsI3v95ystYThRjgkE0WgjSdZnq2
         h2GA==
X-Forwarded-Encrypted: i=1; AJvYcCVb0yUEDmiiaMWJuKijYu+QyB0h/Nb+2BXju4uJXTUMqq5lTdmYOePpYXQR/XaHksE+b9LLGh87iYJu6d2qJeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2bpmrI7WYXUEuKkLX2qiwi5S8eWvxFWm5nBbzd+jP/ZfHFVm
	0jLz28kI0gAK5eSV1OR7nPt/1hI8/SqZWTTGRVqkRizH2DTaoiG2j0BlYpSI7FoK2Gg4AuwGR6K
	QZyK8zN6AdS2oS2A4M+Z/mm1eAZ4nA5xI0Akl
X-Gm-Gg: ASbGncsXvd5INCikvRTJOl5lYsjMaIDHZ6urfyfJypaDIA+wMsCJXCgFtPn7TDH0Yh7
	w6eI5XhAOqChSlGBYwqw82Cr9pVbxvX0KNP3g2ji3QU8V331AO1I933DSvEyb7jxpKY4PFIDqTg
	==
X-Google-Smtp-Source: AGHT+IECyVTDsSJ8bHc2Z+yzaJsoURAySCHTT4AMFt03xJle6a6C4lRtf64jv+S5WgZan+z1km5lScqdXZh9cGoNzes=
X-Received: by 2002:ad4:4eea:0:b0:6d8:8a60:ef24 with SMTP id
 6a1803df08f44-6e4455c1d28mr264143866d6.9.1739258162042; Mon, 10 Feb 2025
 23:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211002600.it.339-kees@kernel.org>
In-Reply-To: <20250211002600.it.339-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Tue, 11 Feb 2025 15:15:50 +0800
X-Gm-Features: AWEUYZnyW25b1De25GbpRIOnFO7-cY_xsFyRWZxtutK3uanHshmpY0hFcYCTR4E
Message-ID: <CABVgOSnWq_0hjKes+Q8kLXyPSS2jGR_Oo01TREj1nTq+52R-0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] KUnit test moves / renames
To: Kees Cook <kees@kernel.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Nicolas Pitre <npitre@baylibre.com>, 
	Rae Moar <rmoar@google.com>, Pedro Orlando <porlando@lkcamp.dev>, 
	Danilo Pereira <dpereira@lkcamp.dev>, Gabriela Bittencourt <gbittencourt@lkcamp.dev>, 
	Gabriel Krisman Bertazi <krisman@suse.de>, Shuah Khan <skhan@linuxfoundation.org>, 
	Diego Vieira <diego.daniel.professional@gmail.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Jakub Kicinski <kuba@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	=?UTF-8?Q?Bruno_Sobreira_Fran=C3=A7a?= <brunofrancadevsec@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Eric Biggers <ebiggers@google.com>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 at 08:31, Kees Cook <kees@kernel.org> wrote:
>
> Hi,
>
> This is rebased to v6.14-rc2. I'll carry it and folks can send me new
> tests, etc, as needed to minimize future collisions.
>
>  v1: https://lore.kernel.org/lkml/20241011072509.3068328-2-davidgow@googl=
e.com/
>
> Thanks!
>
> -Kees

Thanks a lot, Kees -- this has been languishing for too long!

I'm afraid that there might still end up being one or two conflicts,
particularly around the maths tests and crc tests, both of which are
seeing some development. I've CCed the folks writing patches for these
as an FYI.

Otherwise, I'll let you take lib/ tests which depend on / conflict
with the renames.

Cheers,
-- David


>
> Bruno Sobreira Fran=C3=A7a (1):
>   lib/math: Add int_log test suite
>
> Diego Vieira (1):
>   lib/tests/kfifo_kunit.c: add tests for the kfifo structure
>
> Gabriela Bittencourt (2):
>   unicode: kunit: refactor selftest to kunit tests
>   unicode: kunit: change tests filename and path
>
> Kees Cook (1):
>   lib: Move KUnit tests into tests/ subdirectory
>
> Luis Felipe Hernandez (1):
>   lib: math: Move KUnit tests into tests/ subdir
>
>  MAINTAINERS                                   |  19 +-
>  fs/unicode/Kconfig                            |   5 +-
>  fs/unicode/Makefile                           |   2 +-
>  fs/unicode/tests/.kunitconfig                 |   3 +
>  .../{utf8-selftest.c =3D> tests/utf8_kunit.c}   | 149 ++++++------
>  fs/unicode/utf8-norm.c                        |   2 +-
>  lib/Kconfig.debug                             |  27 ++-
>  lib/Makefile                                  |  39 +--
>  lib/math/Makefile                             |   5 +-
>  lib/math/tests/Makefile                       |   4 +-
>  lib/math/tests/int_log_kunit.c                |  74 ++++++
>  .../rational_kunit.c}                         |   0
>  lib/tests/Makefile                            |  41 ++++
>  lib/{ =3D> tests}/bitfield_kunit.c              |   0
>  lib/{ =3D> tests}/checksum_kunit.c              |   0
>  lib/{ =3D> tests}/cmdline_kunit.c               |   0
>  lib/{ =3D> tests}/cpumask_kunit.c               |   0
>  lib/{ =3D> tests}/crc_kunit.c                   |   0
>  lib/{ =3D> tests}/fortify_kunit.c               |   0
>  lib/{ =3D> tests}/hashtable_test.c              |   0
>  lib/{ =3D> tests}/is_signed_type_kunit.c        |   0
>  lib/tests/kfifo_kunit.c                       | 224 ++++++++++++++++++
>  lib/{ =3D> tests}/kunit_iov_iter.c              |   0
>  lib/{ =3D> tests}/list-test.c                   |   0
>  lib/{ =3D> tests}/memcpy_kunit.c                |   0
>  lib/{ =3D> tests}/overflow_kunit.c              |   0
>  lib/{ =3D> tests}/siphash_kunit.c               |   0
>  lib/{ =3D> tests}/slub_kunit.c                  |   0
>  lib/{ =3D> tests}/stackinit_kunit.c             |   0
>  lib/{ =3D> tests}/string_helpers_kunit.c        |   0
>  lib/{ =3D> tests}/string_kunit.c                |   0
>  lib/{ =3D> tests}/test_bits.c                   |   0
>  lib/{ =3D> tests}/test_fprobe.c                 |   0
>  lib/{ =3D> tests}/test_hash.c                   |   0
>  lib/{ =3D> tests}/test_kprobes.c                |   0
>  lib/{ =3D> tests}/test_linear_ranges.c          |   0
>  lib/{ =3D> tests}/test_list_sort.c              |   0
>  lib/{ =3D> tests}/test_sort.c                   |   0
>  lib/{ =3D> tests}/usercopy_kunit.c              |   0
>  lib/{ =3D> tests}/util_macros_kunit.c           |   0
>  40 files changed, 458 insertions(+), 136 deletions(-)
>  create mode 100644 fs/unicode/tests/.kunitconfig
>  rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (64%)
>  create mode 100644 lib/math/tests/int_log_kunit.c
>  rename lib/math/{rational-test.c =3D> tests/rational_kunit.c} (100%)
>  rename lib/{ =3D> tests}/bitfield_kunit.c (100%)
>  rename lib/{ =3D> tests}/checksum_kunit.c (100%)
>  rename lib/{ =3D> tests}/cmdline_kunit.c (100%)
>  rename lib/{ =3D> tests}/cpumask_kunit.c (100%)
>  rename lib/{ =3D> tests}/crc_kunit.c (100%)
>  rename lib/{ =3D> tests}/fortify_kunit.c (100%)
>  rename lib/{ =3D> tests}/hashtable_test.c (100%)
>  rename lib/{ =3D> tests}/is_signed_type_kunit.c (100%)
>  create mode 100644 lib/tests/kfifo_kunit.c
>  rename lib/{ =3D> tests}/kunit_iov_iter.c (100%)
>  rename lib/{ =3D> tests}/list-test.c (100%)
>  rename lib/{ =3D> tests}/memcpy_kunit.c (100%)
>  rename lib/{ =3D> tests}/overflow_kunit.c (100%)
>  rename lib/{ =3D> tests}/siphash_kunit.c (100%)
>  rename lib/{ =3D> tests}/slub_kunit.c (100%)
>  rename lib/{ =3D> tests}/stackinit_kunit.c (100%)
>  rename lib/{ =3D> tests}/string_helpers_kunit.c (100%)
>  rename lib/{ =3D> tests}/string_kunit.c (100%)
>  rename lib/{ =3D> tests}/test_bits.c (100%)
>  rename lib/{ =3D> tests}/test_fprobe.c (100%)
>  rename lib/{ =3D> tests}/test_hash.c (100%)
>  rename lib/{ =3D> tests}/test_kprobes.c (100%)
>  rename lib/{ =3D> tests}/test_linear_ranges.c (100%)
>  rename lib/{ =3D> tests}/test_list_sort.c (100%)
>  rename lib/{ =3D> tests}/test_sort.c (100%)
>  rename lib/{ =3D> tests}/usercopy_kunit.c (100%)
>  rename lib/{ =3D> tests}/util_macros_kunit.c (100%)
>
> --
> 2.34.1
>

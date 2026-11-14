Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669817;
	b=3DeYorifjj72NiPWu2NvFA+wKqvSIplBZdb13RzaoCkSWYn9B4w1NqtN5FvVm9UdItB8
	 fGb5PgC6ag2D8A3QHS630O9AG4LrUwbitQRXkYjIFYJ0Syo+DsgbLUp5d7NSiKEYtQgYj
	 PJ1Ewx6rl9bSO/p5YdSMF3iuiej+LTcFeiNWmbKR/7CigCT27gplkWVPg/WlX5mWuKUF4
	 is3J5OVTQQ6/cjdp/0om9ZOnTwwrC/a06rNyD69GZwgfRIq3ipgefaZxa+/ez+d/fnChE
	 Gq0iB5rv2GqqanVM/D3GUs5UTkfAxd6lqVP4K1zahqB47UNG8GpOk3HtrQLoiSEER0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669817;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C4D8tWy7yjN3qzFEsk5+EZ4DZcACEVgJ2hwFpOY3K6Y=;
	b=pBIKtW8UyxEL5A0nqrIYw35uNGMpDCvWfx5Vxum22Qkp5O/oRT4niGeUlBaPBnfncuo+
	 nRJE71r9mpY37qWLpST6nMbt5vB7G0bfYT8/1csWgq3OcLBSLij343gBEeVcU0rjVA09Z
	 Co7pGfLMpfhGkchi+f36mLj/1yyhmX9D8dqgKJ5kaP2AwmKPe64h58bVahw5GJm1TGbqU
	 zJ+ow5zCPGXxBJKZEs77aWKYnT5Cct+Aa2DQu3wFTKYeEjXF33+fJTsD05VGAWdxMx00Q
	 6+LI8sr9F7QaW5hzmp1G54Z2bmLyZuuA/wYs/M0GZuhmn46ILyPfp33jG6er0miyqqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGUrTCuv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B000606A329;
	Sat, 14 Nov 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGUrTCuv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3B21F000C6;
	Sat, 14 Nov 2026 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669816;
	bh=C4D8tWy7yjN3qzFEsk5+EZ4DZcACEVgJ2hwFpOY3K6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AGUrTCuvsTLpxyq+u6ocR3INzS7q5vcXfjw4dflZEAiaSsrQ+3e6nOWuII2cNEp6v
	 yldMRj0wPlSFWqXSUWSy/j747It1u4r5XgoGCxU47WjwRAZq3mvff8LpB4v7rFqxo5
	 OFHdnv9vByOumQnqBRUF9p03nFomEK5Dwez/DCFGr8v1VaGFF6drXziPl/LHJnWHsN
	 cYAnZGA4Gso5NxEDFd8yASi6IXX9zJXvjfFhZLhH07dPl0LquTIO0Yl9scihJZPEz5
	 9tofEXMZLQx5+eNLOj0P1ExfF0aQbzl8da82WJ3wZk+ZQkSOhVBvREvdgqsEUa9sRE
	 3tKmgn+yBFRbQ==
Date: Sat, 14 Nov 2026 16:23:29 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
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
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 13/19] s390/test_unwind: Use bool for booleans
Message-ID: <024364c695d53c211142c2c1e1e8985fde098abd.1794667407.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794667407.git.alx@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6y3srbiqjfmmmyh"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--j6y3srbiqjfmmmyh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
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
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 13/19] s390/test_unwind: Use bool for booleans
Message-ID: <024364c695d53c211142c2c1e1e8985fde098abd.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

This is obviously good per se, but it will also allow using strprefix()
instead of str_has_prefix().

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 arch/s390/lib/test_unwind.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 6bb3fa5bf925..bb47958f5aed 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -47,7 +47,8 @@ static void print_backtrace(char *bt)
 static noinline int test_unwind(struct task_struct *task, struct pt_regs *=
regs,
 				unsigned long sp)
 {
-	int frame_count, prev_is_func2, seen_func2_func1, seen_arch_rethook_tramp=
oline;
+	int frame_count;
+	bool prev_is_func2, seen_func2_func1, seen_arch_rethook_trampoline;
 	const int max_frames =3D 128;
 	struct unwind_state state;
 	size_t bt_pos =3D 0;
@@ -61,9 +62,9 @@ static noinline int test_unwind(struct task_struct *task,=
 struct pt_regs *regs,
 	}
 	/* Unwind. */
 	frame_count =3D 0;
-	prev_is_func2 =3D 0;
-	seen_func2_func1 =3D 0;
-	seen_arch_rethook_trampoline =3D 0;
+	prev_is_func2 =3D false;
+	seen_func2_func1 =3D false;
+	seen_arch_rethook_trampoline =3D false;
 	unwind_for_each_frame(&state, task, regs, sp) {
 		unsigned long addr =3D unwind_get_return_address(&state);
 		char sym[KSYM_SYMBOL_LEN];
@@ -87,10 +88,10 @@ static noinline int test_unwind(struct task_struct *tas=
k, struct pt_regs *regs,
 		}
 		frame_count +=3D 1;
 		if (prev_is_func2 && str_has_prefix(sym, "unwindme_func1"))
-			seen_func2_func1 =3D 1;
+			seen_func2_func1 =3D true;
 		prev_is_func2 =3D str_has_prefix(sym, "unwindme_func2");
 		if (str_has_prefix(sym, "arch_rethook_trampoline+0x0/"))
-			seen_arch_rethook_trampoline =3D 1;
+			seen_arch_rethook_trampoline =3D true;
 	}
=20
 	/* Check the results. */
--=20
2.55.0


--j6y3srbiqjfmmmyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fPEACgkQ64mZXMKQ
wqnV/g//cJnqxqkGk8aZbatKlhQZVVKgDZhC0CxAMqA2I47KSC8L4UilTHVcRb1+
rcVnSMZ4/JEKT6GB3T536HBIoL/jYyMcWKGi57fNfW9MHU/V9tJ2cGt+DJBSlDT7
Ln5+sDVVRZeYp75Pjtu683tJIZo88nEZJZUTpwxyYDuoqPQGgmdCLgK3CCgaN8d5
QtSWfbZAAvsySaqin9QwJO0mHh48E7wJ7/C+Gzb6dwiulmIMGdqlQ1jFT7HFxtfE
X/OQf4uPRc6mQqR1fQDWmaY4cXPq+9wa/hr029QWGesXxVXYa88pIkDTGhJrZ+Uf
9XPDOcIEZVPVuJ54rI2T2F9pn1YXQTWyUwCtjmO1fptwovy7d70qugWbggxCw0he
Fu/D5JoFWlOequqkn7EuCCJw0cAW1K6bpOkl04whiZ7sc5OWzkJbHew1ORkhyXyT
MX7HKN7gmEOVIiOFim7fIRhI12FFcexcyt5QpCWidoOU4jeyNdglaUHvwAni9GMu
8d1JnfHwZTYF4+yjURDhlIzbsQ/dmxohgmPB4ut4CdZ+ogOtgJ0j9MvVkudg7EZz
Q5O+fp0ms1Ng7XMP4QNjH6Mtz43yDl3nccmrmRD+09fPiFJcBYQsje6CycGCaO9L
XXt2OshF0maNdPHdfPDUYjdag4QI+6Ofam4yLWb6RLy06UIfxww=
=2MnM
-----END PGP SIGNATURE-----

--j6y3srbiqjfmmmyh--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669752;
	b=jFnEAyLTkvY20sgniAQ4PiNWv6pz/1jF8DbLxWNdFwIO1OF2qLA05yhBFAGUd2pKNr8b
	 wgNZR6mDrKm/JQTxFsc+EFT88SssGfNPCuje+MNcCJBifYsdkunrW/T3519JoIKhR9OLP
	 ZgfjIL63JGtcJMgmZHyJHx7rwH7QO0JDcEv16wpbJH3Z9W9pnCF0gapxr1U/4QnDsAVc0
	 mj2MS63vHAMyMh5F2UeLumPTcAsP69a2cs78GK1IV9kdG1Jh37IEPJ7k9Z2DSrFfiCLok
	 +hH/2AJMUIDxG1+2ARk0SMPnF+GNhH/32qucd3QdXN9fW6Y+Y80wvhfdn4Y7wRwZi2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669752;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OP3AzJS4XnYnwQdjtlDg7CLyrUQRQV4aYy6zMdvdmZs=;
	b=ShQr1TRkXe5wG8gufGQaYCx1IYGddBLn+LXXTN7RHXZViS+K+aHfCnIgCtJ0oUmmpfGv
	 k1Tc8Bx4pa8p4V/PwEbsCwV687AfI5ceMOCdvtSfNA/28h4AH5UybJh5K5sfJ6Nf7tfcz
	 NakSafq8+gj3JZtrNTJcTjH/gSR3WgTsldAPLv7Ew49/u2VdEPZwe1fEGf7IydXJCk+JY
	 dycSHWoUgpOOd8FGmv3kZ89SwTuUCWCNmCcJfcdjabIP5ecusT9y22/RMT0zixV7EbMGs
	 4/PQmdw0P1X3nd2HNVaDCENKiiojuyRJyzP4n8kvsblSkdKSUeiB+Y837gTLNUfaceA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtiQVcJA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACB606A327;
	Sat, 14 Nov 2026 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtiQVcJA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A011F000C5;
	Sat, 14 Nov 2026 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669752;
	bh=OP3AzJS4XnYnwQdjtlDg7CLyrUQRQV4aYy6zMdvdmZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WtiQVcJAjSKwpXAXF7zT03821FeCAuztGt67o+fy+aCEa8QfR8T2+53bOfL0ly206
	 ce5pD7IPPJlk3Lfgs86GWQwkrsPykQnkovrwZXywgPF/GUaCpuNq+LR4ZJ+722E+zh
	 gvhpHd3ytBHEw4k5esTe73ORZ4vH2BqfsEwAGrwEin1gQBm+CKVYjRvC+hUd/HiMHl
	 yqZsd31fHgeHDl35rNScXY7AYmEcOn8eiHFf4B1P4tMGdFLNM56KphAigWt3fQx7lu
	 V7mnJpG2gZSfzUCDRCXGmYQ1Rjk3FlC7UgdNnMGuJ0GcnsOufLtJ9w02o41Y/O+neg
	 i3BtwbM0YoFZw==
Date: Sat, 14 Nov 2026 16:22:24 +0100
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
	linux-gpio@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v6 05/19] stddef: Add const_cast()
Message-ID: <2a26768609bd10ebf0f5d2e112f18b3b4fd870d0.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="osgjwfrujg7jszxw"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--osgjwfrujg7jszxw
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
	linux-gpio@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v6 05/19] stddef: Add const_cast()
Message-ID: <2a26768609bd10ebf0f5d2e112f18b3b4fd870d0.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

This macro serves to cast const away without risking unwanted
conversions due to mistakes in the cast.

It's similar to C++'s const_cast(), but it is more restrictive: it can
only cast away 'const', and not arbitrary qualifiers.

Cc: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/stddef.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index e1851c50c89b..26c657465e60 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -194,4 +194,15 @@ enum {
 #define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
 	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
=20
+/**
+ * const_cast() - At most, drop const in the left-most derivation of a poi=
nter
+ *
+ * @T: Type for the cast.
+ * @p: Pointer to be casted.
+ *
+ * Cast @p to type @T.  The macro verifies that @p is of type const @T.
+ * This avoids mistakes that change anything other than 'const' in a cast.
+ */
+#define const_cast(T, p)  _Generic(p, const T: (T) (p))
+
 #endif
--=20
2.55.0


--osgjwfrujg7jszxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fLAACgkQ64mZXMKQ
wqnYpw//Qv1FJzCGFZCVSLb+OmWyxvPWE0p+P+wXkWyg9KP53Qge+keBtgpH6o8p
RXFmJ99aT7D+byW7Madez2ElSCC1ZFex9SkzujbeL8YMotc33TowR86i56sEqC9s
nzRaSVqIN97L7R0++82/amYx//zgKX5j15NVswJZq7WF1iT5OOe9lIekm2NeBMwb
s14v04OVS5eOM8C0dWS9ZPvSr0gmkwCHT542cZU08VCXz0zMyXU8SCqOJqINDIJC
iIYwnSykYQX5AZ7QKU+RXVj+S1ZHGsrrAoacFlx4/m0mKzG0rZYoz2srdCFK6CKE
f0dDYIlhCPXyOgbCyWcE4AYXgg04VE4QGPqcBG5jNYyfGzG8LvkPABWIN17ktqdS
qGJ9i8PUFl/gpqycCbDrxoQpJagHYW0vOfBsSM4z9uqqYMBSYS4+OuxLJr4t5QWt
lrXFFv59v9eRpcbphLWnwpRJ2LhJiyUocDC6i1g5DMC74AtpRbXvIxayq/K+Jr2z
+EQftTGVcuwPmAmDwfkGDwWv9/ZnQUujqS0fmBFYOVNPHY7dIx9djc+UneSJC7oa
lspErxKP/UkYNUHozuhQbRhPlm0LpPOQ8TYgQx4Bazv10DvXdkDQxXyKaFjiqRSm
4sWuO+hGSTbR7UYutEfhfBAZ6b/azskONZvHpmtzpnMPUXZDRwE=
=LMRo
-----END PGP SIGNATURE-----

--osgjwfrujg7jszxw--

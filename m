Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426931;
	b=wFZP7pmtJNKzn98UoWrkqzOHOm1KJamVWh4AvWzjT3nIxq+rrN5WfXdYJY4jSdn+yh9/
	 QRb21/UEwUUrjecpRGugIxusL+s0FjLyvUPZDx0S/OWDW1IvQ/6aJbWd4+vWP9WrpvrfJ
	 7e+0WSuhJZJBM+se+Zm788+7PEWe7xuQUqAF5cUspvebBWyD4blVdhmdeNvrT6Mlwh2Fn
	 J2JWH0LymMcSgMSZTm9eZzemJTBtbdlmgk1qqN0CETB85A0808mdlLGoFVgXXXSBk/O6W
	 P5lnDAxXucspFkarGWkOCUaJvqa3KKhUtKOz3W1s9PlSt/xHJmyAz6wcGLZDdkZkWQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426931;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6PRpf/9rawqSFhk0xcek3r0xqro0rjp5j8rVTRD5Y0M=;
	b=lZMoefWSdIteUaNb5UPvmybMqeMQ0XBJWehJygAGjtzSO/nQJJeukNVBfkQOKxKV+atq
	 qZieTTYNdI71gVycZi5u05nhl/bDc3/z0wl60ITX2VnxeH1SYzF+++XfZdIP2q3FFCWXB
	 XM50wtNpsao0HLdAYbipOyzv5OmUwsv4ItdtGE+I3Vvm6ETiQ6ZVZczMzCSyOpBrgAY3J
	 iw/AVm5CiyDeJ0w6uAnrMwgR1qwpToaKMaPvjxrcNKTPBvEgKXIRi7huE2z+XnA4FZeCw
	 zqB+1UOe9mmMfHvybvXgMzO+ROOb6vLqYNmE38CzB9bMQ7DCVNapvWBPluHl23imwyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFKZbpjM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352C606A332;
	Wed, 11 Nov 2026 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFKZbpjM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486041F00A09;
	Wed, 11 Nov 2026 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426931;
	bh=6PRpf/9rawqSFhk0xcek3r0xqro0rjp5j8rVTRD5Y0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HFKZbpjMLQB1NZ21rmRQYH79vAMFkdWMfewwVEC9oSJsEod8XGb43l2haBWVU25US
	 66uBGy59jpcYkNjrW4c6Qjfju/fgSOqYD/ivSARKSwnE/VL04r+gl/5EfHe7lcagyy
	 rkc0GUc+1qP8uG3VPxwf8HWn6BUq9+XY9EfTf9tYQoeM+8DBdmK/B7SsQIkYYTSLtl
	 scTFLtfxzwuNVB45dLAwNurZGBltvZbadukRAKM3lgTFDOA9q9JgBm6OjztfWNaHlM
	 onEhj9XezLbNfe/qchC8m1VKZ/xrvQSiIrlmovPmQUuSUfdsZhMlahTpSf36MAjc/5
	 xuHJVtwk8zJ4Q==
Date: Wed, 11 Nov 2026 20:55:23 +0100
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 2/6] string: Warn if the prefix is the empty string
Message-ID: <cd09427148a0c4718b46029c9e806f9dc1622f9b.1794425425.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="fjk6tklj7m7tsotj"
Content-Disposition: inline
In-Reply-To: <cover.1794425425.git.alx@kernel.org>


--fjk6tklj7m7tsotj
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 2/6] string: Warn if the prefix is the empty string
Message-ID: <cd09427148a0c4718b46029c9e806f9dc1622f9b.1794425425.git.alx@kernel.org>
References: <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794425425.git.alx@kernel.org>

This corner case is mishandled by this function.
Warn if it happens.  Also, document that if such corner case
is needed, strprefix() is preferable.

Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop=
-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index d08ca10c39a2..9444e216ab86 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -574,6 +574,10 @@ static inline char *strprefix(const char *s, const cha=
r *prefix)
  * This is similar to strprefix(), but returns an offset instead of
  * a pointer.
  *
+ * Unlike for strprefix(), if the prefix is an empty string, the
+ * behavior is undefined.  If you need to support arbitrary prefixes,
+ * use strprefix().
+ *
  * Returns:
  * * strlen(@prefix) if @str starts with @prefix
  * * 0 if @str does not start with @prefix
@@ -581,6 +585,7 @@ static inline char *strprefix(const char *s, const char=
 *prefix)
 static __always_inline size_t str_has_prefix(const char *str, const char *=
prefix)
 {
 	size_t len =3D strlen(prefix);
+	WARN_ON_ONCE(len =3D=3D 0);
 	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
 }
=20
--=20
2.55.0


--fjk6tklj7m7tsotj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yCsACgkQ64mZXMKQ
wqmXCA/3XcjlsH0huy0cN2sXKUz6Gd8dsHGcGtZvSIT0bx+lcJWYkbw2gkc7GqEi
vTT9UDdaa/vGm1x/loYpW8qWwGq9Sp756mrQLc82/RVPvhESuIpftETj3YKqs+vW
uffkSAq9yHh9CVvSm8yXPPRsskxkgQTIMvl7mm9Oalnt9o+tvhun4sh9qXCArH0l
7dGjp/f2+ZZhGihE/qCDjQEDO62mOtcSQo4W71iQp9wcISQ8t+UovlxJonGJKEkY
OqC1/yfSzn2rhnh81KEoSRAWmd2qNUjMkU8I9nW68zsV9JpEgoUwfN0B8cZTfqDw
UNpfz7k17RNYezrv/cjxQP78uLrso3JD+KT50egS8OjE+ieT1QXzh/EMR7UIEq95
I4zdo5wr1yQZF1c54EXIk6U3Ldxn36jxf/9sgwl0c+doOE6X6dTM3iMUuO9hz8b4
UeP8xV2xB9/yTXHCkJ/OO59IyDBs42m776dczQ/JTO0jS06onszHN+zQoE835TEi
rWNg7XF8wDrnJzdPrJNwpyMWcI442F4SnrFkojX3wls1A+j5/1/wNtDw5OVtdSjJ
n8qigUsFggmEWv4Kwv6YSBN17DPYGDV7NCQDutkdCXtVghUatjuNiBuOO7/C6p+n
RdG/Oltg8h+m5S/Ny00K09ZKhLb8yhd+umBrvJsj6fQhh+lzHA==
=PpwF
-----END PGP SIGNATURE-----

--fjk6tklj7m7tsotj--

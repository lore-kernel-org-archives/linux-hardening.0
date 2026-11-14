Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669776;
	b=RLsqSyFPbjmVhX0I8jB2efoBHz4XGpuF6xIM3y+xL5AMUEpIfc3g3VDtdEf0Qu9GXDKF
	 T8EYxVGQpToLVR4TAEydJ31Luv5Q+OQUqFOllehG9fwsqo6Brrw0Q0Q6NzRWu4csYCKmt
	 WWhN+T/6l0LOvTuxOcNT7NPwRvtfu7qySAdRw8rw/YQHAOl5agW8iVK3WhHyEyX8eY09x
	 0bal5+Sc3/IMauQzPxBRxOR8PNxJ3/zhwVo5d3d8Qck5LQXbri1K5jr35Z1Ax9qNiWQVl
	 Xv6313U3ZYpzU3OBC9l2r08DpJaCrWzzq2kyqya4vNG6UQRgFGm/k85QNmxT4Qu4HCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669776;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hzdxJka0eQ/09r15UlCX3+QgNz+4joamuCtkkp+OfuQ=;
	b=yXZVfPsh4CMf5881OdmUAs/4uFoI97eGlXjlUIYtMUglEYnlq7ZTRAC1NSi1PueFLrA6
	 DTNPz9LBMHwpC4u4Sfnou5QRUtOr1vscreI48PjoKjORkXDpkZt2hE3Y80mC08i63B9y+
	 Az35ozPV/KIRLaatp1bdiMH6zmS1Uejk9jFjEEfMRpba79l08qtBoo9PPcDhT8SyN/5bK
	 VQRpq1DqUVrjOp9OoVNJfy/57FPWyzKE0CgwZa455qgb+oE9WkUgTtX3IfqrTcyBA3/ZT
	 lNeRW7+eMre6KhZaaO73vLgQlWfdNvf/P0w7QEABEANgU67gTnQyb3z2FqxKwKdPN8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7YKBvrx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B6606A332;
	Sat, 14 Nov 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7YKBvrx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE421F000CF;
	Sat, 14 Nov 2026 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669776;
	bh=hzdxJka0eQ/09r15UlCX3+QgNz+4joamuCtkkp+OfuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M7YKBvrxmtIhSkVzJIS5mCxgHF0rYo6OJIGUwFm3yT7lyRUe9LJZOfavh+6qs7fh3
	 4frNOfHx/3yhJhgmxg80E5t6V35VHwzypwDgFHgseh3wzKtzuNSUnwaMLTEkxhVVW5
	 Wnkbo35BRopYLupomoy4c3rqWZTLrpS5jTudg1V4lcYKlOLzUTCKhxmX+Pd8Ug4oEA
	 G56D1ZdwQYA/cyGMCOafB4F8yxPxoF8Yz2dEcmt+nuoiejXW6Ke8IoBQ+/b+bBNqyY
	 tVhedEDdIA99KOVlXeZ/9/TP9UjEKTnyXJiqSNxnkoiOvTkp8uZdM3UQa33hjF7HVK
	 9keFIeEBSkyZA==
Date: Sat, 14 Nov 2026 16:22:49 +0100
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
Subject: [PATCH v6 08/19] perf map: Use bool for return type instead of int
Message-ID: <8a3c50cfe298a82869619b2e676e4b9c5da589d5.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="3ccdlp5suel6rycl"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--3ccdlp5suel6rycl
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
Subject: [PATCH v6 08/19] perf map: Use bool for return type instead of int
Message-ID: <8a3c50cfe298a82869619b2e676e4b9c5da589d5.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

This is not strictly necessary, but is more robust and readable.
We already use bool in that file, so this improves consistency too.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 41cdddc987ee..944f10d32796 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -16,7 +16,7 @@
 #include "thread.h"
 #include "vdso.h"
=20
-static inline int is_android_lib(const char *filename)
+static inline bool is_android_lib(const char *filename)
 {
 	return strstarts(filename, "/data/app-lib/") ||
 	       strstarts(filename, "/system/lib/");
--=20
2.55.0


--3ccdlp5suel6rycl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fMgACgkQ64mZXMKQ
wqmjVxAAgmd8UT1wnpWzOpu4PcBc1BJdVclCM+ut0EFH5B1XWDlNoe4O4NoSWoUW
krX6vT5QvYQuJagTx4qPAmWlfRlWdfA/krhgeiA+s32NsGHqFpyKf6v3wd+ZEeWq
VkaVHafK3IDpXnmJEstRpwcIdMW28A2vxngQbgV0sEA06MuorE5ZENKWRBEop/fp
pyDIBDmbDXXReOHpKmXfg43jV+MlKVbG0RDgH0cAm+mkqyR4nQXFmUqk7Geyc0F3
/Ddj52TZdECI0g6PaCY9tb/pMeenrSXgovJ9JYzOQRWtVmQwT+99FINyQRMtPp25
G2nZQejDlktEMrQvp0TBKbnI747WMpN4D4cbrC3SOKmuBvKZkXzaBV4MRRjOsVv4
uZNYWkeNBw8T3oIwxy6MOSocAyu8MA9HQCBI/8MSuXlNuP6vvimOBPug4eqM9Add
k1TOEtLGprGlMHM393A/XiYrsoT16AbLYB6zPMEn/xHb7wNg5EDqf6dOmUMyGX8x
GqnexQxPTRwFhEoaTKmMGY2mms/zGXvmu7BjMCvxhALwA61bKOFqDEVbSthG4BH6
7hPZ4WyDc8PNQvf3iqxGoxgMasrz4nleBgHlGWvRh+9dmTlXBvwzx+14XNAuSkac
eADo94XAUVU5/cG2guXatGaolZf6sbbBAB/irHNb8xsKlt3IPBc=
=fP12
-----END PGP SIGNATURE-----

--3ccdlp5suel6rycl--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768383;
	b=OU7BVR3TdA8NOk39tYMwqjFQsy48hO57WLHFfpOxKYv9n/FcGqs0N9hNwBdWo9sxz1WZ
	 4fFgZPYzNXQCKDQVvo4C+mIeL5RClVFojCq/r0MRdwj2lYtvaeKgzVOInyVCPvWoyOWr2
	 Y5J0QZ5DsZdtzBitnk3X6vZ7CZcuYoJi19y+FPKzARvwMyjQxj93LTbI9FyiOUdQlpCY8
	 Xg3Hwnv/tROXp6g3puS/ZlaHTZspaKKmNTZ2uhAbKJGH90JvKg8wQypWYQqop8Y+hcZT8
	 QWT1ptvmdH6hqUerqltnjyXUdF6aprll3vRSWI+bITlJy4rblK1I8qEU3QaAdE0Urvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768383;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KoJSFZsHBs3kIAXDN97K9Q73gk+TWhURLNxXf/w+TTI=;
	b=L2n3MSP76OuLzZvAXPgtlZrThHCbHefbOjz9/idkKR5jPvi40k3JAuNOjIQvYaSJ9+Lo
	 cVYoEvzyItuBcHQ8HRv9zj8zn55D2oN0URsZIrM7OzroLyilPofB3pf+6GWz6QzPv+vBK
	 //euaEnzFP6WtFa63PF2doBt/XM7g8FVYuVNH3IJGrDUOztZMNoSztl/XhTE1BpphPgpr
	 gsnzHaQ8CoO91RwMAqhe3e8mhKfOF3DOo5IUaMe350h+d18NArKNS7f5Tdh86qTlKtxDH
	 2FSIimBx7CiB2nS7cx3ft2MUdVgKTfGqbhS8fgqRyYcikJttw8/dYjVYMUDUHqZ+lWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUICaTI4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4F606A31E
	for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUICaTI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675CC1F000C4;
	Sun, 15 Nov 2026 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768383;
	bh=KoJSFZsHBs3kIAXDN97K9Q73gk+TWhURLNxXf/w+TTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iUICaTI4OuZk41yaKejof5K7HebSGpoMenmuNxzgNye88o2TaH3FhPlgk1xWHKThF
	 tG+0sU++R1WocvxXnFkcZEnIghNmB+3v82gwGUaXezDsftQPoyZGkhJXTW4APVCjr+
	 d23mfFfvMH5JRp4xV3UEQkGzFYDTjclfzsZytir06rJstcMMxyV9gOQG7VC/f5rCga
	 4KO3YuRgRQWEEBe+jTqpSSDXELMsA+b8FyZLMQEaNCBY2Yq/YyLHRtm7rb39vVxLCD
	 1r8ELV20Gyuj00qq1TMD96yBjBfZ/NkPfi+4qgb7NZl2ijOP+Ve8rlmStFePPuTYEp
	 lEBkMaJVHD7yQ==
Date: Sun, 15 Nov 2026 19:46:20 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 3/4] treewide: Use streq(3) instead of confusing uses of
 strncmp(3)
Message-ID: <b93e0d00573973327bf90ad1a10806743d692d19.1794767906.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794767906.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="wt3ehubhuzaffvrh"
Content-Disposition: inline
In-Reply-To: <cover.1794767906.git.alx@kernel.org>


--wt3ehubhuzaffvrh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 3/4] treewide: Use streq(3) instead of confusing uses of
 strncmp(3)
Message-ID: <b93e0d00573973327bf90ad1a10806743d692d19.1794767906.git.alx@kernel.org>
References: <cover.1794767906.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794767906.git.alx@kernel.org>

Uses of strncmp(a, b, N) where N=3D=3Dstrlen(b)+1 are really the same as
strcmp(a,b).  It's hard to distinguish whether the strcmp(3) behavior
was intentional, or it strstarts() behavior was intended.

This code seems to have been confused, and probably thought using
strncmp(3) was somehow safer than strcmp(3), but it is not.

Let's rewrite with streq(3), which makes it more readable.
This patch is not changing the behavior of the existing code.
If any of these was actually a bug and intended to write strstarts(),
that should be fixed in a separate patch.

These cases were found with the following script:

$ seq 20 \
| while read n; do
	git grep -E 'strncmp\([^,]*, "[^"]{'"$n"'}", '"$(expr 1 + $n)"'\)';
done;

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 arch/arm/mach-omap2/sr_device.c                    | 8 ++++----
 arch/mips/bcm47xx/time.c                           | 2 +-
 arch/powerpc/kernel/security.c                     | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c         | 2 +-
 fs/ocfs2/filecheck.c                               | 6 +++---
 net/netfilter/xt_set.c                             | 2 +-
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 8 ++++----
 tools/testing/selftests/kvm/steal_time.c           | 2 +-
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c  | 4 ++--
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_devic=
e.c
index 758d90e0340b..dfc27dc25293 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -92,12 +92,12 @@ static int __init sr_init_by_name(const char *name, con=
st char *voltdm)
 	struct omap_volt_data *volt_data;
 	static int i;
=20
-	if (!strncmp(name, "smartreflex_mpu_iva", 20) ||
-	    !strncmp(name, "smartreflex_mpu", 16))
+	if (streq(name, "smartreflex_mpu_iva") ||
+	    streq(name, "smartreflex_mpu"))
 		sr_data =3D &omap_sr_pdata[OMAP_SR_MPU];
-	else if (!strncmp(name, "smartreflex_core", 17))
+	else if (streq(name, "smartreflex_core"))
 		sr_data =3D &omap_sr_pdata[OMAP_SR_CORE];
-	else if (!strncmp(name, "smartreflex_iva", 16))
+	else if (streq(name, "smartreflex_iva"))
 		sr_data =3D &omap_sr_pdata[OMAP_SR_IVA];
=20
 	if (!sr_data) {
diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index 74224cf2e84d..6ab6f55ce47e 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -60,7 +60,7 @@ void __init plat_time_init(void)
=20
 	if (chip_id =3D=3D 0x5354) {
 		len =3D bcm47xx_nvram_getenv("clkfreq", buf, sizeof(buf));
-		if (len >=3D 0 && !strncmp(buf, "200", 4))
+		if (len >=3D 0 && streq(buf, "200"))
 			hz =3D 100000000;
 	}
=20
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 600596cb4ffb..8c1484ae6c21 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -273,7 +273,7 @@ enum stf_barrier_type stf_barrier_type_get(void)
 /* This is the generic flag used by other architectures */
 static int __init handle_ssbd(char *p)
 {
-	if (!p || strncmp(p, "auto", 5) =3D=3D 0 || strncmp(p, "on", 2) =3D=3D 0 =
) {
+	if (!p || streq(p, "auto") || strncmp(p, "on", 2) =3D=3D 0 ) {
 		/* Until firmware tells us, we have the barrier with auto */
 		return 0;
 	} else if (strncmp(p, "off", 3) =3D=3D 0) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ether=
net/intel/i40e/i40e_ddp.c
index daa9f2c42f70..c84eddf98b06 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -452,7 +452,7 @@ int i40e_ddp_flash(struct net_device *netdev, struct et=
htool_flash *flash)
 	/* If the user supplied "-" instead of file name rollback previously
 	 * stored profile.
 	 */
-	if (strncmp(flash->data, "-", 2) !=3D 0) {
+	if (!streq(flash->data, "-")) {
 		struct i40e_ddp_old_profile_list *list_entry;
 		char profile_name[sizeof(I40E_DDP_PROFILE_PATH)
 				  + I40E_DDP_PROFILE_NAME_MAX];
diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index 75334e4bd082..3fcd538ff2c5 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -258,11 +258,11 @@ ocfs2_filecheck_args_get_long(const char *buf, size_t=
 count,
 static int
 ocfs2_filecheck_type_parse(const char *name, unsigned int *type)
 {
-	if (!strncmp(name, "fix", 4))
+	if (streq(name, "fix"))
 		*type =3D OCFS2_FILECHECK_TYPE_FIX;
-	else if (!strncmp(name, "check", 6))
+	else if (streq(name, "check"))
 		*type =3D OCFS2_FILECHECK_TYPE_CHK;
-	else if (!strncmp(name, "set", 4))
+	else if (streq(name, "set"))
 		*type =3D OCFS2_FILECHECK_TYPE_SET;
 	else
 		return 1;
diff --git a/net/netfilter/xt_set.c b/net/netfilter/xt_set.c
index 4ae04bba9358..6f4e306196fe 100644
--- a/net/netfilter/xt_set.c
+++ b/net/netfilter/xt_set.c
@@ -436,7 +436,7 @@ set_target_v3_check_hooks(const struct xt_tgchk_param *=
par)
 	const struct xt_set_info_target_v3 *info =3D par->targinfo;
=20
 	if (info->map_set.index !=3D IPSET_INVALID_ID) {
-		if (strncmp(par->table, "mangle", 7)) {
+		if (!streq(par->table, "mangle")) {
 			pr_info_ratelimited("--map-set only usable from mangle table\n");
 			return -EINVAL;
 		}
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/tes=
ting/selftests/dmabuf-heaps/dmabuf-heap.c
index 1d49df671919..af4692942810 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -507,9 +507,9 @@ static int numer_of_heaps(void)
 	int heaps =3D 0;
=20
 	while ((dir =3D readdir(d))) {
-		if (!strncmp(dir->d_name, ".", 2))
+		if (streq(dir->d_name, "."))
 			continue;
-		if (!strncmp(dir->d_name, "..", 3))
+		if (streq(dir->d_name, ".."))
 			continue;
 		heaps++;
 	}
@@ -533,9 +533,9 @@ int main(void)
 	ksft_set_plan(12 * numer_of_heaps());
=20
 	while ((dir =3D readdir(d))) {
-		if (!strncmp(dir->d_name, ".", 2))
+		if (streq(dir->d_name, "."))
 			continue;
-		if (!strncmp(dir->d_name, "..", 3))
+		if (streq(dir->d_name, ".."))
 			continue;
=20
 		ksft_print_msg("Testing heap: %s\n", dir->d_name);
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selft=
ests/kvm/steal_time.c
index 82b94a82dd03..64327e8fbd78 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -526,7 +526,7 @@ int main(int ac, char **av)
 	bool verbose;
 	int i, cpu;
=20
-	verbose =3D ac > 1 && (!strncmp(av[1], "-v", 3) || !strncmp(av[1], "--ver=
bose", 10));
+	verbose =3D ac > 1 && (streq(av[1], "-v") || streq(av[1], "--verbose"));
=20
 	/* Set CPU affinity so we can force preemption of the VCPU */
 	cpu =3D pin_self_to_any_cpu();
diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/test=
ing/selftests/kvm/x86/xen_shinfo_test.c
index aaa414c677ad..e254720df86f 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -438,8 +438,8 @@ int main(int argc, char *argv[])
 	pthread_t thread;
 	bool verbose;
=20
-	verbose =3D argc > 1 && (!strncmp(argv[1], "-v", 3) ||
-			       !strncmp(argv[1], "--verbose", 10));
+	verbose =3D argc > 1 && (streq(argv[1], "-v") ||
+			       streq(argv[1], "--verbose"));
=20
 	int xen_caps =3D kvm_check_cap(KVM_CAP_XEN_HVM);
 	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO);
--=20
2.55.0


--wt3ehubhuzaffvrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr5/fwACgkQ64mZXMKQ
wqlW6Q/+O84iXjLhqrfibocobE8unCIyqHEnZJS/GXNZh209bypBhf9WtQnvcr/4
BA+ooY29H/oLrGw6gSEXaphDAg1IxzjsiuDWQcIY8Sw7ObO7cAqBNmoIgL4qu6U9
6be3H8mTgilWttz2it0jil0IC3BFgzab6jXj8IqqzFnjAfZPorhejzB9xpwou+iy
tioJvyCJcGQuco7svFTtnz9rXrs7EazDjt1sMQKJckxqFzLM23u1D3Cu+jC/tJV3
U7y0dTW98LG38Q2TzFSlDxVWsmGuSZrOb4yTiqvvyLPs2GCCouYWlM1G/YlO5n9b
wXa+PSA/bHu3LXWembSUIuEHczMcLToo4IDTn7owHwxuX44o1bj0vS758WeLpfs2
KwAcklwko7p+CYJj8viaJAorg2v4p1IxCsI9fUYaNpO1Tfr2fgf53Nd8LUiDaAWC
R0h3E/b4SHKre5wFMel3/H4oqbDcE6WOlSKbkuCM9FyL1vrSqLjS4/OagOsmAwqr
WeKLFGf0WrN0exVzahLK99gPdGjben2MLkjZomfal7DOtchrcTZU9ezD+fWF/cPW
ro0VgCgqhCuJIzwiJQQ7tfqbRT2NBlzgla/G0j2/DogpnAtPqzKwMSRxNn3GVkfP
d/GZ2LBA+WI/fsj9Iox5xiBRVxO433U5b0XRsok5cf1OwcspViM=
=qxVK
-----END PGP SIGNATURE-----

--wt3ehubhuzaffvrh--

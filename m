Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7939DBD0
	for <linux-hardening@vger.kernel.org>; Wed,  9 Sep 2026 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983678; cv=pass; b=gEi6WkCiInGArU+2KwVPYx1ccBoNg3/48IsZOHeaLzfDEWAqAF4aDI/RU0Y/Y36Qx/68NjgZPJQNT53AoDMREkxqmCADsw+kuBwcO11X9n8SXP7YwfeN0b97Q4v1vGUmBhmEFamAMwKII685kkZ9CwU7WW50rosBP/XI2wg+PNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983678; c=relaxed/simple;
	bh=aKBP1jc6s7Kb9AtFShE/8Kec3yPgLaa7AVvdFtHLVNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U09qA+F12yjp6DSy5NtRmlOJGLtjWYUISYzBZmKngXeJ4ouhfjavFOgvKJvpt6QCuMPAdY6x1yP0dqWfHAfC584PVeb8kHn/atVeDTbZ1FHI0MRL4TBBlaYEe538ZQHPws7IaVISvdYMFu3FR67UJVN9Bo2CyuoGgtAcutbLGSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGaIlqp3; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGaIlqp3"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-963f63fe025so1916666241.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Sep 2026 12:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788983675; cv=none;
        d=google.com; s=arc-20260327;
        b=QWtTFARZCEStbSD9epPVM2i78RYBasdeMWyDP0nFeuUXVcg0gUhXVCT/uZ6ugH5MM8
         rIcOOYBWs3q1w3MnIsq8ebTsjSkahLtN0+Yvf5gpXuqc8xewB/M6LwEi1bMHVsklVCrM
         5Vo6vSfaIE9PIcu2EdKbxI3UEZaoXv/LwhRqIqy4bWlBmIak1vsWLPuL/RrhQSGpaiU0
         SsphNbm++FSoW9KvpJJjgAT97S3UEdXusVXe3GYh0YP1Fun6kt0ZwKIgQC/a+a5PhhHR
         DRv0isHUs+y33Ec1h7kR64PPSO8vu2bmDAZifWa2oZqB8swHTV8ZtVZJvjRQ2wjTndOC
         EkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JlgccNgxVbugZNqdrvfNlhMGvViQkc+NBOA9MC8f2/k=;
        fh=SYNVse9Tn/Erzoq25zzwzm8k/J+/139Z2iCA+mW4B08=;
        b=l7hxClqCpkTbV2Xr1dWnEMIQSSG12fuBZSEDS+2hHEtoQo6f3D+L18mLIf5OoDDLsW
         gw8dP0n1KOzLfPKtArHJn8rkRXzbxl+AFQMO+t1uuiLSdX3OMnAuAZUZC9BqRdPZAkc9
         phOS+HVtmxG67x3CiDX3z80vM8uRQvi2Qs9WJnw8whfpH9lyZj8izhBq5VJaE1sM5VCs
         blZBsA9aXyKX5RGT0wc4VvuQEOxdzuzt419+9dUoEJiZ/6pCyuRbtGPAAOf3NcoRsDlK
         E10D5BflpTjyckGPzGgQ8kXNQz7MJE5lnAOQNe1mJ4zCmggbWjuN8P6N4KsyvqiklMrZ
         TsrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788983675; x=1789588475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JlgccNgxVbugZNqdrvfNlhMGvViQkc+NBOA9MC8f2/k=;
        b=rGaIlqp3hcgEkhc9SxQeNKcSHrVwe452joKcPDgEiVxaVyIaIdvGPYEzR2j6TGcd7U
         OQsgSVRMK9HamF8QecJrVzoN8xYmGvbGXp8kO41vtRLyjryxUBFShpGzAxKZz7NFOkJ2
         f4nnt7MIIUCs+dxBrHlZ4xdPVygpQ0LjKs7AOhvOT6CqCGvoBr+FpTTCXYwgYUeWyPNk
         /hY4IRELweBJMLbBKU/oAXPTRMfl5U7CM8a3YdY26lMunKObldZIgOo1sgFAUx0do4Ba
         4koc2W99FG3TpoJ5WywIGA9GtaTuWMYanmRIXG5SV4y2P0CrMTV6yhNyexVq9L4NXIRP
         D5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983675; x=1789588475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JlgccNgxVbugZNqdrvfNlhMGvViQkc+NBOA9MC8f2/k=;
        b=LxTC3elESG/HuDJluKJSJk0QPrZDcF9JStipy4LpMZ7LmkydBV/np/F9tgWgWFRCmj
         fAkBOhOgKwMSq29phZoE9V1gZNoWH+7wARJ31G2KY0HyzXi0zMx5HnLL8JsatQquEgLu
         2IRpX5Cax03tpIO053xlP0TZjisgFt5Qg8R7gU5r7AzP7fhdQKdznHrMbOfgk1c5lwff
         iKlG5eIos+F0r8box0IbTeXAZ/wyc/z6OzedlgOPti7Mnc9Vx8LrRa9msCyVJPFEwc3M
         Ly1rhVxQXyascQFIwMxbdgmybQklIgG4uzfAMYHm/r+cf8RaaNEE0ffbJJuX8mHcQ4xy
         zE2w==
X-Forwarded-Encrypted: i=1; AKwUvBxzTotk/GjhTOPHxC0B9hGA2nzx84aiWw/wJJcc1Fqp15rCSmOLuGMeNLGrN+932vzUS+NMDA+0D3u3D6bCXb4=@vger.kernel.org
X-Gm-Message-State: AFuF++ny5QV02N0FDHJzH4b8Ob4BIhc30ZztgQBJ9AmK8bBclBBDGjOY
	QV1iJSc6xmRNOPvdvWgoh1/sE7nPIGGPzoApuIFuqvxNjysYd6H5ipbtzrC/N+BVGao0R7MuUaI
	D3FKyPo7s4pJRCDgLtQsgcCiIa1Vg9K9YHF4o7N0=
X-Gm-Gg: AYBFou0Nyf5zwRGG2UkLzlzQUWIN9ZtPRDwzWIV4M11WmgtNt7km1HUByo50gVEZaYm
	0Hnr5GD0/eRO912UDNboAWK6xEk5XKVJn9jFSCT8b35PMxoJAyEzEIrJ4hMRuahkXzUOJXIf42R
	6nYtfNqpz5XTBOYGV/YMjrVkL7BRp4WSrMuHFWF0WoqXlVBv9BNvQ8aKMZBeZm0kgWxDXkxmL2d
	x4asOjXF4P+sk8zxT5EQhI6W7VW8wqlNQK8a0WkFV+omF6NWThrj1haBoRq34fRIcVH7ye931uq
	aQHs9YM4H8pPvDgjqSgFLGnNl4dZhU+RZ9cvxd321hyvxYpXfuYRudZ1pkVHSEkeuuxe7tak/Z9
	xOJpz1unct1GrVRFsxjo+tk8V/6AAvlEPh6ArIqGCTRoeuyyO50V6
X-Received: by 2002:a05:6102:fa8:b0:78f:5bab:4761 with SMTP id
 ada2fe7eead31-78f5bab4867mr5091092137.8.1788983674408; Wed, 09 Sep 2026
 12:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125155.1136740-3-morbo@google.com> <20260908222734.3048684-1-morbo@google.com>
 <20260908222734.3048684-2-morbo@google.com> <76DEB9F0-5263-4AB0-816F-71A57F3B67BB@mainlining.org>
In-Reply-To: <76DEB9F0-5263-4AB0-816F-71A57F3B67BB@mainlining.org>
From: Bill Wendling <morbo@google.com>
Date: Wed, 9 Sep 2026 12:54:17 -0700
X-Gm-Features: AcwNN1ViNghJSNmdSoLp_huEp4YyT8-YIp0mFgB8ip3vTJjz-BjF1pqR5q5E2Ns
Message-ID: <CAGG=3QVX9irf_S-jBBUsV4Y1MZJyNPkKNATawREQ=3FqtBXYag@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] userns: Add KUnit test suite for uid_gid_map
To: Bradley Morgan <brads@mainlining.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:36=E2=80=AFAM Bradley Morgan <brads@mainlining.org=
> wrote:
> On 8 September 2026 23:27:30 BST, Bill Wendling <morbo@google.com> wrote:
> >diff --git a/init/Kconfig b/init/Kconfig
> >index 8583d9f06c52..27c1ffc675bf 100644
> >--- a/init/Kconfig
> >+++ b/init/Kconfig
> >@@ -1457,6 +1457,17 @@ config USER_NS
> >
> >         If unsure, say N.
> >
> >+config USER_NS_MAP_KUNIT_TEST
> >+      tristate "KUint test for user
>
> Hmm! s/KUint/KUnit
>
*headdesk*

-bw

>  namespace map insertion" if !KUNIT_ALL_TESTS
> >+      depends on USER_NS && KUNIT
> >+      default KUNIT_ALL_TESTS
> >+      help
> >+        This builds the KUnit test for user namespace uid/gid map inser=
tion.
> >+        It validates map insertion, limits, dynamic allocation of the
> >+        extended extents array, and mapping sorting functions.
> >+
> >+        If unsure, say N.
> >+
> > config PID_NS
> >       bool "PID Namespaces"
> >       default y
> >diff --git a/kernel/Makefile b/kernel/Makefile
> >index 1e1a31673577..2a64282749b8 100644
> >--- a/kernel/Makefile
> >+++ b/kernel/Makefile
> >@@ -141,6 +141,7 @@ obj-$(CONFIG_WATCH_QUEUE) +=3D watch_queue.o
> >
> > obj-$(CONFIG_RESOURCE_KUNIT_TEST) +=3D resource_kunit.o
> > obj-$(CONFIG_SYSCTL_KUNIT_TEST) +=3D sysctl-test.o
> >+obj-$(CONFIG_USER_NS_MAP_KUNIT_TEST) +=3D tests/user_ns_map_kunit.o
> >
> > CFLAGS_kstack_erase.o +=3D $(DISABLE_KSTACK_ERASE)
> > CFLAGS_kstack_erase.o +=3D $(call cc-option,-mgeneral-regs-only)
> >diff --git a/kernel/tests/.kunitconfig b/kernel/tests/.kunitconfig
> >new file mode 100644
> >index 000000000000..b3d1206fd81a
> >--- /dev/null
> >+++ b/kernel/tests/.kunitconfig
> >@@ -0,0 +1,4 @@
> >+CONFIG_KUNIT=3Dy
> >+CONFIG_NAMESPACES=3Dy
> >+CONFIG_USER_NS=3Dy
> >+CONFIG_USER_NS_MAP_KUNIT_TEST=3Dy
> >diff --git a/kernel/tests/user_ns_map_kunit.c b/kernel/tests/user_ns_map=
_kunit.c
> >new file mode 100644
> >index 000000000000..24c21e43a36c
> >--- /dev/null
> >+++ b/kernel/tests/user_ns_map_kunit.c
> >@@ -0,0 +1,98 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/*
> >+ * KUnit test for user namespace map insertion and sorting.
> >+ */
> >+
> >+#define pr_fmt(fmt) "user_namespace: " fmt
> >+
> >+#include <kunit/test.h>
> >+#include <linux/user_namespace.h>
> >+
> >+#define NR_EXTENTS (UID_GID_MAP_MAX_BASE_EXTENTS + 5)
> >+
> >+static void user_ns_map_insert(struct kunit *test)
> >+{
> >+      struct uid_gid_map map;
> >+      struct uid_gid_extent extent;
> >+      int i, ret;
> >+
> >+      memset(&map, 0, sizeof(map));
> >+
> >+      /* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS elements */
> >+      for (i =3D 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
> >+              extent.first =3D i * 10;
> >+              extent.lower_first =3D i * 100;
> >+              extent.count =3D 5;
> >+
> >+              ret =3D insert_extent(&map, &extent);
> >+              KUNIT_ASSERT_EQ(test, ret, 0);
> >+      }
> >+
> >+      KUNIT_EXPECT_EQ(test, map.nr_extents, UID_GID_MAP_MAX_BASE_EXTENT=
S);
> >+
> >+      /* Verify the elements ended up in the 'extent' array */
> >+      for (i =3D 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
> >+              KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
> >+              KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100)=
;
> >+              KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
> >+      }
> >+}
> >+
> >+static void user_ns_map_insert_extended(struct kunit *test)
> >+{
> >+      struct uid_gid_map map;
> >+      struct uid_gid_extent extent;
> >+      int i, ret;
> >+
> >+      memset(&map, 0, sizeof(map));
> >+
> >+      /* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS elements */
> >+      for (i =3D 0; i < NR_EXTENTS; i++) {
> >+              int value =3D 9 - i;
> >+
> >+              extent.first =3D value * 10;
> >+              extent.lower_first =3D value * 100;
> >+              extent.count =3D 5;
> >+
> >+              ret =3D insert_extent(&map, &extent);
> >+              KUNIT_ASSERT_EQ(test, ret, 0);
> >+      }
> >+
> >+      KUNIT_EXPECT_EQ(test, map.nr_extents, NR_EXTENTS);
> >+
> >+      /* Now sort the map to set up reverse mapping */
> >+      ret =3D sort_idmaps(&map);
> >+      KUNIT_ASSERT_EQ(test, ret, 0);
> >+      KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
> >+
> >+      /* Verify the elements are in 'forward' and that sorting is corre=
ct */
> >+      for (i =3D 0; i < map.nr_extents; i++) {
> >+              KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
> >+              KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i * 100=
);
> >+              KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> >+
> >+              KUNIT_EXPECT_EQ(test, map.reverse[i].first, i * 10);
> >+              KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i * 100=
);
> >+              KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
> >+      }
> >+
> >+      kfree(map.forward);
> >+      kfree(map.reverse);
> >+}
> >+
> >+static struct kunit_case user_ns_map_test_cases[] =3D {
> >+      KUNIT_CASE(user_ns_map_insert),
> >+      KUNIT_CASE(user_ns_map_insert_extended),
> >+      {}
> >+};
> >+
> >+static struct kunit_suite user_ns_map_test_suite =3D {
> >+      .name =3D "user_ns_map",
> >+      .test_cases =3D user_ns_map_test_cases,
> >+};
> >+
> >+kunit_test_suite(user_ns_map_test_suite);
> >+
> >+MODULE_LICENSE("GPL");
> >+MODULE_DESCRIPTION("KUnit test for user namespace map insertion");
> >+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> >diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> >index 786dbf0506ca..d8cbefd36598 100644
> >--- a/kernel/user_namespace.c
> >+++ b/kernel/user_namespace.c
> >@@ -1,5 +1,6 @@
> > // SPDX-License-Identifier: GPL-2.0-only
> >
> >+#include <kunit/visibility.h>
> > #include <linux/export.h>
> > #include <linux/nsproxy.h>
> > #include <linux/slab.h>
> >@@ -786,7 +787,8 @@ static bool mappings_overlap(struct uid_gid_map *new=
_map,
> >  * Takes care to allocate a 4K block of memory if the number of mapping=
s exceeds
> >  * UID_GID_MAP_MAX_BASE_EXTENTS.
> >  */
> >-static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent=
 *extent)
> >+VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
> >+                                 struct uid_gid_extent *extent)
> > {
> >       struct uid_gid_extent *dest;
> >
> >@@ -822,6 +824,7 @@ static int insert_extent(struct uid_gid_map *map, st=
ruct uid_gid_extent *extent)
> >       *dest =3D *extent;
> >       return 0;
> > }
> >+EXPORT_SYMBOL_IF_KUNIT(insert_extent);
> >
> > /* cmp function to sort() forward mappings */
> > static int cmp_extents_forward(const void *a, const void *b)
> >@@ -857,7 +860,7 @@ static int cmp_extents_reverse(const void *a, const =
void *b)
> >  * sort_idmaps - Sorts an array of idmap entries.
> >  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BAS=
E_EXTENTS.
> >  */
> >-static int sort_idmaps(struct uid_gid_map *map)
> >+VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
> > {
> >       if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
> >               return 0;
> >@@ -878,6 +881,7 @@ static int sort_idmaps(struct uid_gid_map *map)
> >
> >       return 0;
> > }
> >+EXPORT_SYMBOL_IF_KUNIT(sort_idmaps);
> >
> > /**
> >  * verify_root_map() - check the uid 0 mapping
> >
>
> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.ne=
t/

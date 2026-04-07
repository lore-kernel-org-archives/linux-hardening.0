Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC533BBCF
	for <linux-hardening@vger.kernel.org>; Tue,  7 Apr 2026 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592432; cv=pass; b=ky292PZi5KbKUAxNAWxNI1Dn66KMiLy3+/tBWws1dN+QeF1z0dnWsy+vTOLcyndmnWV+20MftZqa0AU1FWdHoQzwPM3VyjBeH3i6a8uV1bBRgzMbdmrALeJzTAqPFExPYhGBUIhU+XGz4oH/OijSdbVvFiv5GsXAFxn6ntqhUiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592432; c=relaxed/simple;
	bh=e8wrO5vikecJwWYmKqPCipX+VB+wtmE5VFXv9Q/3tHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIvmPGxY/iiuMEsKLRn0Dn54YWSjNA6hIsrWqWlCGvS6kp/RgYAAFbCywhljFtAAMWfucruMZiKr6c7gKFbI+6DNxniz3GbeMI/NYFjjAxLxTAAfdN7t8SSzaLKOm1NPf5/CJiNEN1PicEbst6d6o3r0R/um2ROWh6uvfpntn3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XievHkLn; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XievHkLn"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64eaf8aa893so4747552d50.3
        for <linux-hardening@vger.kernel.org>; Tue, 07 Apr 2026 13:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775592429; cv=none;
        d=google.com; s=arc-20240605;
        b=IAfVF5GAUc0txawFFXKUdzYjJILArLEnXZK600Yg9vAGcjlJsvTWmDkThImBSqiwXE
         qSQW6yYqxbpe9p6X3pccj9j6XuYupwbi0c1Rkuk2XNac+z0IfoYU1h2AC4+qjsTrjVOA
         9DZz7IAtZ2mguRXmBFRA5HzNRkB6iNIFyiiP28v8MGLf6f6aOA74LnxvyCwHIXGyM0pk
         eUytM6PBxe06qkJGOyrdclA4QUCXKapqpKhtEUzK1ijU7vrN/AFUjA+wxfF3HPhrbYgl
         0wOck4JuYnOMAoo8I+cJckS44EZPRlbkAb605eHapKhCCA4OztXuH8iJ3MVvachO1rn3
         WZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        fh=Q6pcXo5KG/7Fu32y4dHm15UGskEUmc5IDUagF9THmXA=;
        b=Gv13URwrwqeHalB13+JFNISI4og9fxAHkQ5wcpE6rx1MMMlzvliTg9WMoYXDKITJ5+
         C8aEIQd5DDsKuF2ZPqCYacNxxBzG1fY8BPV8ZXNsDhuxfQhddhOZcGRM5fLBQENUdIG/
         nZfrNe02X64TCZGTH6eQowBO7sHCkEFfdqxhozPXG86g/caa2e5x7mReeByvl/6vMMgv
         GkVGs18XkWce18H4H4zQIW+tq7C498UK6666KxLOdnAEvcleHU+/S/3x8OBByqbnfSAz
         nLQ+lZWbp1SPm3brag85mVJQ8mi6SchFgL9GDBrDHpTPZ/EzlQc9PYqvawSrxGplyhnb
         dIbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592429; x=1776197229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        b=XievHkLnOheSp2jIgR8kESbGKj6CngEzh/Mb8Dey29za/HJrCDQg2qhnais2SlgGsT
         UaCbedRWKPdMdRnyezUm8lA1rrg21G4VJiEti7B8MctxOPpz8yNajlEjI1pHVNli3bxP
         hXbRlHkQ7JCAO0Dk8eWfpypyvXOwwQd1S7Tz3pePpWaqHdNoUW8YLhHKnG0vIM489e0z
         CNB1+xA3NgU6P8lU005PRZVgFz6btE0HEqghbxjWeR+W2OJnI6yZybLOrmpHfMlKjFEl
         2OFtwh+xgt326yFwjeQ88zWM7q1zfYtnMookj0Xvxx75hoR6QoUv/zjuT/tZkn8LqJmo
         7+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592429; x=1776197229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        b=PBXKquKg+i1kiOq0C/QPgO35q0wfZyo2VM154iwJBnrSDnnzYgJ/0fxbFRFixrU5uK
         g95kRuAK6VPDv3N981d2z4cqj7Bl7yJxacB2vL3oQwzyL/1v29dds+i9MP5PZPEqA2K0
         00piFCC41O6GAgacGA0iwQvW3dl4HaYMO8G7lca9YfPzbKzhnDpOX2RKUM5COeSgncjL
         MKhZEAZJVTajU3RJux++mEjQjaVLvoOaxqrC2u3BeO463qynm+0KxYF/D7v1gdJCZeIG
         2cJcBPZxX4HURlt6W6zueK1WFGDaAc7Xm6VTyHsR70vFOgYVHZ0LZhGeJLjv41ivUxZ8
         Ahig==
X-Forwarded-Encrypted: i=1; AJvYcCW7E4lIpXVnGD/juntBRPLugRhB7gL9RqT7pXo6cmzre10g1jWLZ1iwhA4WyhJSQC8kuIJ3x2WdYjtGFwwmOus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5bSt/1xqtdLw3O4wALuVNKVobZ5O2JxMabfvkobgvMUK1+M8
	rNrQL86f/5uGKpSfMgchPgkj1SA/MsQViH3eX2my9B1leihFC9q+vWssxg6GuXIjidqeEbPV63b
	/n8KctfpT9HHvaMJezDS22XHZeekgy2E=
X-Gm-Gg: AeBDietad18QVOcEL/K7F5qjLMRHYTrhqoRRcL8BE3Vl05ARwqRBlZAIv9uW+PD3pAI
	htfJ8gsSJ+5okCm59OR0aQBPEkhv1lglCfkkCivywXKIZ7brHYN3O0O28EaX66xlHi8QBmg0G/9
	RyuNEZ1rK6+jGe8+Lq/5jp6+azU4ICZKBtL8TxvPvsPMqSU4Qthsgd2RsKspF9rGDs2wB716WyV
	H6svZ0pP3WZBwtwMPuYkxBkd9a8WtFeoZAD0Q2wMgd/EFiO/DuToCZnuKhMc+fczHXEXdD3XeF1
	4emfk8LWeabk2npT0GelW9gSiYn5nPtXpyqe1W+AY5z2DTcMNg6Ta4xm7w2UStIwyOZTwQ==
X-Received: by 2002:a05:690e:1447:b0:64a:e781:891f with SMTP id
 956f58d0204a3-6504878d8b5mr18273755d50.28.1775592429222; Tue, 07 Apr 2026
 13:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZ1FrL8qvvKuktBF@kspp> <d04e11af-5c1b-44a2-aebc-a0ee4fb79802@embeddedor.com>
In-Reply-To: <d04e11af-5c1b-44a2-aebc-a0ee4fb79802@embeddedor.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Apr 2026 16:06:57 -0400
X-Gm-Features: AQROBzBVPVG9lewQAg4xWgXaY_QVQNvPxJT95QjFDd687G3MpHiw6Ni_WDKPrq4
Message-ID: <CABBYNZKJ9Xqwo0CF8wwax68etv8DywG8BmN=V1CWoWcfiq2mog@mail.gmail.com>
Subject: Re: [PATCH][next] Bluetooth: hci.h: Avoid a couple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Apr 7, 2026 at 3:58=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Friendly ping: who can take this, please?

Just resend as this is no longer available via patchwork.

> Thanks
> -Gustavo
>
> On 2/24/26 00:31, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > struct hci_std_codecs and struct hci_std_codecs_v2 are flexible
> > structures, this is structures that contain a flexible-array member
> > (__u8 codec[]; and struct hci_std_codec_v2 codec[];, correspondingly.)
> >
> > Since struct hci_rp_read_local_supported_codecs and struct
> > hci_rp_read_local_supported_codecs_v2 are defined by hardware, we
> > create the new struct hci_std_codecs_hdr and struct hci_std_codecs_v2_h=
dr
> > types, and use them to replace the object types causing trouble in
> > struct hci_rp_read_local_supported_codecs and struct
> > hci_rp_read_local_supported_codecs_v2, namely struct hci_std_codecs
> > std_codecs; and struct hci_std_codecs_v2_hdr std_codecs;.
> >
> > Also, once -fms-extensions is enabled, we can use transparent struct
> > members in both struct hci_std_codecs and struct hci_std_codecs_v2_hdr.
> >
> > Notice that the newly created types does not contain the flex-array
> > member `codec`, which is the object causing the -Wfamnae warnings.
> >
> > After these changes, the size of struct hci_rp_read_local_supported_cod=
ecs
> > and struct hci_rp_read_local_supported_codecs_v2, along with their
> > member's offsets remain the same, hence the memory layouts don't
> > change:
> >
> > Before changes:
> > struct hci_rp_read_local_supported_codecs {
> >          __u8                       status;               /*     0     =
1 */
> >          struct hci_std_codecs      std_codecs;           /*     1     =
1 */
> >          struct hci_vnd_codecs      vnd_codecs;           /*     2     =
1 */
> >
> >          /* size: 3, cachelines: 1, members: 3 */
> >          /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > struct hci_rp_read_local_supported_codecs_v2 {
> >          __u8                       status;               /*     0     =
1 */
> >          struct hci_std_codecs_v2   std_codecs;           /*     1     =
1 */
> >          struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     =
1 */
> >
> >          /* size: 3, cachelines: 1, members: 3 */
> >          /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > After changes:
> > struct hci_rp_read_local_supported_codecs {
> >       __u8                       status;               /*     0     1 *=
/
> >       struct hci_std_codecs_hdr  std_codecs;           /*     1     1 *=
/
> >       struct hci_vnd_codecs      vnd_codecs;           /*     2     1 *=
/
> >
> >       /* size: 3, cachelines: 1, members: 3 */
> >       /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > struct hci_rp_read_local_supported_codecs_v2 {
> >       __u8                       status;               /*     0     1 *=
/
> >       struct hci_std_codecs_v2_hdr std_codecs;         /*     1     1 *=
/
> >       struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 *=
/
> >
> >       /* size: 3, cachelines: 1, members: 3 */
> >       /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > With these changes fix the following warnings:
> >
> > include/net/bluetooth/hci.h:1490:31: warning: structure containing a fl=
exible array member is not at the end of another structure [-Wflex-array-me=
mber-not-at-end]
> > include/net/bluetooth/hci.h:1525:34: warning: structure containing a fl=
exible array member is not at the end of another structure [-Wflex-array-me=
mber-not-at-end]
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   include/net/bluetooth/hci.h | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 89ad9470fa71..572b1c620c5d 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1468,8 +1468,12 @@ struct hci_rp_read_data_block_size {
> >   } __packed;
> >
> >   #define HCI_OP_READ_LOCAL_CODECS    0x100b
> > -struct hci_std_codecs {
> > +struct hci_std_codecs_hdr {
> >       __u8    num;
> > +} __packed;
> > +
> > +struct hci_std_codecs {
> > +     struct hci_std_codecs_hdr;
> >       __u8    codec[];
> >   } __packed;
> >
> > @@ -1487,7 +1491,7 @@ struct hci_vnd_codecs {
> >
> >   struct hci_rp_read_local_supported_codecs {
> >       __u8    status;
> > -     struct hci_std_codecs std_codecs;
> > +     struct hci_std_codecs_hdr std_codecs;
> >       struct hci_vnd_codecs vnd_codecs;
> >   } __packed;
> >
> > @@ -1504,8 +1508,12 @@ struct hci_std_codec_v2 {
> >       __u8    transport;
> >   } __packed;
> >
> > -struct hci_std_codecs_v2 {
> > +struct hci_std_codecs_v2_hdr {
> >       __u8    num;
> > +} __packed;
> > +
> > +struct hci_std_codecs_v2 {
> > +     struct hci_std_codecs_v2_hdr;
> >       struct hci_std_codec_v2 codec[];
> >   } __packed;
> >
> > @@ -1522,7 +1530,7 @@ struct hci_vnd_codecs_v2 {
> >
> >   struct hci_rp_read_local_supported_codecs_v2 {
> >       __u8    status;
> > -     struct hci_std_codecs_v2 std_codecs;
> > +     struct hci_std_codecs_v2_hdr std_codecs;
> >       struct hci_vnd_codecs_v2 vendor_codecs;
> >   } __packed;
> >
>


--=20
Luiz Augusto von Dentz

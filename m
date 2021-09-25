Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85860C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 10:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CDB61041
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 10:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhIYKjw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 25 Sep 2021 06:39:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:60199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233380AbhIYKjv (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 25 Sep 2021 06:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
        s=badeba3b8450; t=1632566272;
        bh=kSl2RSrvRL/8zW7biwFttzoiCaZta+AEGRZX+5ZjQm0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LTBydLyQK/3NQ3qBFkoZMQJUoFYgBejQ2UdqkN6uoL8JLnCu2UjBkzuomQRbXEuUs
         FIbFz4uq2pvAxNbWyqu7V2+41U6zEe+9msUO9tq8mcNMb04040ZM1GpaGjnSkL0xcd
         r0C/44Urhv4C5HcnXDzpzpr0k0FDDKDFfY0tWPO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3il-1mIhMR0x6B-00TRr1; Sat, 25
 Sep 2021 12:37:52 +0200
Date:   Sat, 25 Sep 2021 12:37:41 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over
 open coded arithmetic
Message-ID: <20210925075920.GC1660@titan>
References: <20210918150500.21530-1-len.baker@gmx.com>
 <202109192246.B438B42EF@keescook>
 <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
X-Provags-ID: V03:K1:CgHOh+lKF+ZFXQwCxqWKgAUh0KM+oCrU4+5NHwasLpUOyG7wmhd
 mjp6LSWoWRb+vlGSpV96w5yoArA79M1XPRCwIKQCly2JnC+LQHNsVXITK4aKdmvfoyK+LV0
 epmmt+/alaxwwZLluE+cE1ykwrZtgyFy6A9BsnvE38VrFoAXlTnsvXxPW0KnREbVT77srBl
 DpYAG3LNGlOEWs4pR1QTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0gZui/plYqY=:FAhmTpFX7N1mxnruyQpAdc
 ARi6vj0MpZdBf5acN+241powB+5YQIJTZwmbFIJmDoh8BW+2xK0/W218aSbYYv1v8qrLZjAgr
 BheuLIDkzEFKBY3NklXj+QGRqAkRY6b7oP1VZNHUgRZ1Bq1e1mChdpSO5JlaM1W/oUuim4Kht
 WT0H1B0C7xkJ4qLizzAg0pil57D6PHEBAsed52iAzYZiuYsSx1O7IIjJnEqwLB2NqZyzntd6E
 eBvdwhXItVqiU7s/yZOvlZcVUFk7RwOiGyu+aHzUkuYumXfNLTS965i05MbL0jf99r7iZaUHe
 LHlRvwIet8d+b9bJC3E3q+c53CXclweZELkmrCovrTSMe94/SY+Qay9eGR51GrSg8++8Wx4wZ
 W6eUAtmAW1fFqgPgj+h5yJlcEvQ6LOkn9xrdSjYAVhN5I0PMx8Fbv2Eo5aLJfIlqDSCLIajeS
 XzPNuE02ifqb0568c/HO5pLWxdaXzMKr4uo7qPi8iYNFZMDjQjVLCqCNlquPpLxDR8TYYNM7a
 uSKEWFL/A6vhXj/ur/pQYHeHhKW2tD9ezwYe6g3IJZxHi2ychd72lnIvTFdN/+VXSvLcn+8i7
 gveGqQRIT3qUP9fZd5aQTeFl8A4lVBN4mLJpz60bhxWeFnCIJC2K4cbKjiV6KnInGpq69woAi
 pLAaFDnjX+BccL3RiTvOd3QyaIIpNU3o5+kPdWkwRrOjAHculXcxRMCdBvoMvDhVLKJ4p8Gx9
 GwwbvMROLK3d1vbC9qKwhtOUAtE0jrCfNqBZC3vjM0pagRYgYA6BqsJT9jTss1YB4ehnqE4Kl
 OsWaVUmDazxf+g6rcaNZEj016xLU6oqJbe3L5rd5jq/D1x1LMednHIA1Nqsi+piopjqX8NSVQ
 xYJtDQQ7uKX6jculULtblCHsv8DyOzMiyBcAL2lv3gJzkOYn3VRhKLH0B8pzGYrkpL96wRKNg
 DlOPwbWfBvaq73uuutnw1ObEviZUqV2MOy2RXCb1v+NngiHpMA3wTE1fj3AdTNGCDuA8MY10Z
 hGLqPkKflde5JmHxQGOyD/wx+woGHGvYRwG852Z6KhTTReFH7ys1jTwQXJVHQPjxIxSXwKsaH
 HGJZbsI+szLgjI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On Tue, Sep 21, 2021 at 03:46:23PM +0200, Hans de Goede wrote:
> On 9/20/21 7:58 AM, Kees Cook wrote:
> > On Sat, Sep 18, 2021 at 05:05:00PM +0200, Len Baker wrote:
> >>
> >>  static struct attribute_set *create_attr_set(unsigned int max_member=
s,
> >> @@ -1020,13 +1020,11 @@ static struct attribute_set *create_attr_set(=
unsigned int max_members,
> >>  		return NULL;
> >>
> >>  	/* Allocates space for implicit NULL at the end too */
> >> -	sobj =3D kzalloc(sizeof(struct attribute_set_obj) +
> >> -		    max_members * sizeof(struct attribute *),
> >> -		    GFP_KERNEL);
> >> +	sobj =3D kzalloc(struct_size(sobj, a, max_members + 1), GFP_KERNEL)=
;
> >
> > Whoa, this needs a lot more detail in the changelog if this is actuall=
y
> > correct. The original code doesn't seem to match the comment? (Where i=
s
> > the +1?) So is this also a bug-fix?
>
> Kees, at first I thought you were spot-on with this comment, but the
> truth is more subtle. struct attribute_set_obj was:
>
> struct attribute_set_obj {
>         struct attribute_set s;
>         struct attribute *a;
> } __attribute__((packed));
>
> Another way of looking at this, which makes things more clear is as:
>
> struct attribute_set_obj {
>         struct attribute_set s;
>         struct attribute *a[1];
> } __attribute__((packed));
>
> So the sizeof(struct attribute_set_obj) in the original kzalloc call
> included room for 1 "extra" pointer which is reserved for the terminatin=
g
> NULL pointer.
>
> Changing the struct to:
>
> struct attribute_set_obj {
>         struct attribute_set s;
>         struct attribute *a[];
> } __attribute__((packed));
>
> Is equivalent to changing it to:
>
> struct attribute_set_obj {
>         struct attribute_set s;
>         struct attribute *a[0];
> } __attribute__((packed));
>
> So the change in the struct declaration reduces the sizeof(struct attrib=
ute_set_obj)
> by the size of 1 pointer, making the +1 necessary.
>
> So AFAICT there is actually no functional change here.

Hans, thanks for the explanation. Yes, this is the reason I added the "plu=
s 1".
Not only based on the comment :)

Regards,
Len
